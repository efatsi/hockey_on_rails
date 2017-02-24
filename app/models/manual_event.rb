class ManualEvent < ApplicationRecord
  belongs_to :game

  validates :game, :event_type, :ip_address, presence: true

  def clock
  end

  def period
  end

  def wall_clock
    created_at
  end

  def description
    "Manually triggered event: #{ip_address}"
  end
end
