class Game < ApplicationRecord
  validates :description, :remote_id, presence: true
  validates :remote_id, uniqueness: true

  has_many :events
end
