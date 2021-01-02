class CommentSerializer < ActiveModel::Serializer
  belongs_to :review
  belongs_to :user

  attributes :id, :content, :username, :user_pic, :review_username, :review_user_id, :game_api_id, :game_name
end
