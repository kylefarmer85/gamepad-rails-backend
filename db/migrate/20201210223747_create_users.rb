class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :email
      t.string :pic
      t.string :fav_genre
      t.string :fav_game

      t.timestamps
    end
  end
end
