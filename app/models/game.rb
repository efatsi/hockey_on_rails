class Game < ApplicationRecord
  validates :remote_id, uniqueness: true

  has_many :events
end
