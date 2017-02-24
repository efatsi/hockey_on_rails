class Game < ApplicationRecord
  validates :description, :remote_id, presence: true
  validates :remote_id, uniqueness: true

  has_many :events,     dependent: :destroy
  has_many :clock_data, dependent: :destroy
end
