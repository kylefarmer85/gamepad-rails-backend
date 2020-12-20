class User < ApplicationRecord
  has_secure_password
  validates :username, :email, uniqueness: true
  validates :username, :password, :email, :pic, :fav_genre, :fav_game, presence: true

  has_many :favorites, dependent: :destroy
  has_many :games, through: :favorites
  has_many :reviews, dependent: :destroy

  # Will return an array of follows for the given user instance
  has_many :received_follows, foreign_key: :followed_user_id, class_name: "Follow"

  # Will return an array of users who follow the user instance
  has_many :followers, through: :received_follows, source: :follower
  
  
  # returns an array of follows a user gave to someone else
  has_many :given_follows, foreign_key: :follower_id, class_name: "Follow"
  
  # returns an array of other users who the user has followed
  has_many :followings, through: :given_follows, source: :followed_user

end
