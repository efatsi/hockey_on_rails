class ClockDatum < ApplicationRecord
  belongs_to :game

  validates :game, :period, :clock, presence: true
end
