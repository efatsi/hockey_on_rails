# Create all games for today:
today    = Date.today.strftime("%Y/%m/%d")
response = HTTParty.get("https://api.sportradar.us/nhl-ot4/games/#{today}/schedule.json?api_key=g8zxvn32anknmadk5ayuhdka");
body     = JSON.parse(response.body)

body["games"].each do |g|
  Game.create(
    description: "#{g["away"]["name"]} at #{g["home"]["name"]}",
    remote_id:   g["id"],
    game_time:   g["scheduled"])
end
