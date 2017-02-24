class AddWallClockToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :wall_clock, :datetime
  end
end
