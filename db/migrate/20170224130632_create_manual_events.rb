class CreateManualEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :manual_events do |t|
      t.integer :game_id
      t.string :event_type

      t.timestamps
    end
  end
end
