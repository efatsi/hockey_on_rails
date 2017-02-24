class CreateClockData < ActiveRecord::Migration[5.0]
  def change
    create_table :clock_data do |t|
      t.integer :game_id
      t.string :period
      t.string :clock

      t.timestamps
    end
  end
end
