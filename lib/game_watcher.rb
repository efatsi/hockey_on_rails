class GameWatcher
  attr_reader :game

  def initialize(game_id)
    @game = Game.find_by(id: game_id)
  end

  def watch
    if game.present?
      while(true) do
        execute_loop
      end
    else
      puts "Invalid game id"
    end
  end

  def execute_loop
    if game.watch
      puts "Beginning loop..."

      response = HTTParty.get("https://api.sportradar.us/nhl-ot4/games/#{game.remote_id}/pbp.json?api_key=g8zxvn32anknmadk5ayuhdka")
      body = JSON.parse(response.body)

      process_periods(body["periods"])
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

    Event.create({
      game:        game,
      period:      "#{period["type"]} #{period["number"]}",
      remote_id:   event["id"],
      clock:       event["clock"],
      description: event["description"],
      event_type:  event["event_type"],
      updated:     event["updated"],
    })
  end
end
