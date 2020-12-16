class AddUserPicToReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :user_pic, :string
  end
end
