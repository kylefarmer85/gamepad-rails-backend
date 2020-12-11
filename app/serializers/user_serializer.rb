class UserSerializer < ActiveModel::Serializer
  has_many :favorites
  has_many :games, through: :favorites
  has_many :reviews

  attributes :id, :username, :email, :pic, :fav_genre, :fav_game 
end
