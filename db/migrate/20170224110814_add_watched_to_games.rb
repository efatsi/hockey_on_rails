class AddWatchedToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :watch, :boolean, default: false
  end
end
