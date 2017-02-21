class GameWatcher

  def watch
    return if Game.none?

    @game = Game.last

    while(true) do
      execute_loop
      sleep(10)
    end
  end

  def execute_loop
    puts "Beginning loop..."

    response = HTTParty.get("https://api.sportradar.us/nhl-ot4/games/#{@game.remote_id}/pbp.json?api_key=g8zxvn32anknmadk5ayuhdka")
    body = JSON.parse(response.body)

    process_periods(body["periods"])
  rescue => e
    puts "Error raised: #{e}"
  end

  def process_periods(periods = [])
    Array(periods).each do |period|
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
      game:        @game,
      period:      "#{period["type"]} #{period["number"]}",
      remote_id:   event["id"],
      clock:       event["clock"],
      description: event["description"],
      event_type:  event["event_type"],
      updated:     event["updated"],
    })
  end
end
