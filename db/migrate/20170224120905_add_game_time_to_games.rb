class AddGameTimeToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :game_time, :datetime
  end
end
