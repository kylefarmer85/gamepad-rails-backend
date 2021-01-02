class ReviewSerializer < ActiveModel::Serializer
  belongs_to :user
  belongs_to :game
  has_many :comments

  attributes :id, :user_id, :game_id, :content, :rating, :username, :game_name, :game_api_id, :user_pic, :created_at, :comments
end
