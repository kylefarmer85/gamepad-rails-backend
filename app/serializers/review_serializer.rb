class ReviewSerializer < ActiveModel::Serializer
  belongs_to :user
  belongs_to :game

  attributes :id, :user_id, :game_id, :content, :rating, :username, :game_name
end
