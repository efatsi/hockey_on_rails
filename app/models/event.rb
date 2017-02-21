class Event < ApplicationRecord
  validates :remote_id, uniqueness: true

  belongs_to :game
end
