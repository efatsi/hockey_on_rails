class ManualEvent < ApplicationRecord
  belongs_to :game

  validates :game, :event_type, presence: true
end
