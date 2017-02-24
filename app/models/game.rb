class Game < ApplicationRecord
  validates :description, :remote_id, presence: true
  validates :remote_id, uniqueness: true

  has_many :events,        dependent: :destroy
  has_many :clock_data,    dependent: :destroy
  has_many :manual_events, dependent: :destroy

  def all_events
    events + manual_events
  end

  def fetch_additional_info
    response = HTTParty.get("https://api.sportradar.us/nhl-ot4/games/#{remote_id}/pbp.json?api_key=g8zxvn32anknmadk5ayuhdka");
    body     = JSON.parse(response.body)

    update(game_time: body["scheduled"])
  end
end
