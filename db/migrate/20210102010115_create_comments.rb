class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :content
      t.string :username
      t.string :user_pic
      t.string :review_username
      t.integer :review_user_id
      t.integer :game_api_id
      t.string :game_name
      t.references :user, null: false, foreign_key: true
      t.references :review, null: false, foreign_key: true

      t.timestamps
    end
  end
end
