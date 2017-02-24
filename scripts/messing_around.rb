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


# Pusher stuff
Pusher.trigger(["games", "game-1"], 'update', {
  message: 'hello world'
})


# Rando requests
response = HTTParty.get("https://api.sportradar.us/nhl-ot4/games/5dbd6400-43dc-4fb0-a510-c11532fba4a0/pbp.json?api_key=g8zxvn32anknmadk5ayuhdka");
body     = JSON.parse(response.body)
