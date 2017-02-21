class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :remote_id
      t.string :clock
      t.string :description
      t.string :event_type
      t.datetime :updated
      t.integer :game_id
      t.string :period

      t.timestamps
    end
  end
end
