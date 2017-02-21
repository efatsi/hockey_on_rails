class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :description
      t.string :remote_id

      t.timestamps
    end
  end
end
