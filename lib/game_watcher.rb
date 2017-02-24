class GameWatcher
  attr_reader :game

  def initialize(game_id)
    @game = Game.find_by(id: game_id)
  end

  def watch
    if game.present?
      while(true) do
        execute_loop

        if @stop_watching
          puts "End of 3rd period, shutting down watcher."
          game.update(watch: false)
          return
        elsif @game_destroyed
          return
        end
      end
    else
      puts "Invalid game id"
    end
  end

  def execute_loop
    if game.watch
      puts "Beginning loop..."

      response = HTTParty.get("https://api.sportradar.us/nhl-ot4/games/#{game.remote_id}/pbp.json?api_key=g8zxvn32anknmadk5ayuhdka");
      body     = JSON.parse(response.body)

      process_periods(body["periods"])
      save_clock_data(body["clock"], body["periods"])
    elsif Game.find_by(id: game.id).nil?
      puts "Game has been destroyed, not watching"
      @game_destroyed = true
    else
      puts "Game not being watched. Retry in 1 minute."
      sleep(60)
    end
  rescue => e
    puts "Error raised: #{e}"
  end

  def process_periods(periods = [])
    period = Array(periods).last

    if period.present?
      process_events(period["events"], period)
    end
  end

  def process_events(events = [], period)
    Array(events).each do |event|
      next if Event.exists?(remote_id: event["id"])

      save_event(event, period)
    end
  end

  def save_event(event, period)
    puts "Inserting event: #{event["event_type"]}"

    if event["description"] == "End of 3rd Period."
      @stop_watching = true
    end

    case event["event_type"]
    when "goal"
      Pusher.trigger(["games", "game-#{game.id}"], 'update', {
        message: "#{event["attribution"]["name"]}: goal scored!",
        goal:    true
      })
    when "penalty"
      Pusher.trigger(["games", "game-#{game.id}"], 'update', {
        message: "#{event["attribution"]["name"]}: #{event["description"]}"
      })
    when "shotsaved"
      Pusher.trigger(["games", "game-#{game.id}"], 'update', {
        message: "#{event["attribution"]["name"]}: #{event["description"]}"
      })
    when "faceoff"
      Pusher.trigger(["games", "game-#{game.id}"], 'update', {
        message: "#{event["attribution"]["name"]}: won faceoff"
      })
    end

    Event.create({
      game:        game,
      period:      "#{period["type"]} #{period["number"]}",
      remote_id:   event["id"],
      clock:       event["clock"],
      wall_clock:  event["wall_clock"],
      description: event["description"],
      event_type:  event["event_type"],
      updated:     event["updated"],
    })
  end

  def save_clock_data(clock, periods = [])
    return if !clock || Array(periods).empty? || periods.first["events"].empty?

    period = Array(periods).last

    game.clock_data.create(
      clock:  clock,
      period: "#{period["type"]} #{period["number"]}"
    )
  end
end
