class AddGameNameToReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :game_name, :string
  end
end
