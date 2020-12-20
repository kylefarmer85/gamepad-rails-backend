class AddIndexToFollows < ActiveRecord::Migration[6.0]
  def change
    add_index :follows, :follower_id
    add_index :follows, :followed_user_id
    add_index :follows, [:follower_id, :followed_user_id], unique: true
  end
end
