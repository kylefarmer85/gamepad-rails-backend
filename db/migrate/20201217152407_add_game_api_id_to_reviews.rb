class AddGameApiIdToReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :game_api_id, :integer
  end
end
