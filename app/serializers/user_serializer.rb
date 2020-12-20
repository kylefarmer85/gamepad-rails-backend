class UserSerializer < ActiveModel::Serializer
  has_many :favorites
  has_many :games, through: :favorites
  has_many :reviews

  has_many :received_follows, foreign_key: :followed_user_id, class_name: "Follow"

  has_many :followers, through: :received_follows, source: :follower

  has_many :given_follows, foreign_key: :follower_id, class_name: "Follow"
  
  has_many :followings, through: :given_follows, source: :followed_user


  attributes :id, :username, :email, :pic, :fav_genre, :fav_game 
end
