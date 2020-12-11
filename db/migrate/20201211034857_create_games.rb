class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :name
      t.string :image
      t.integer :game_api_id

      t.timestamps
    end
  end
end
