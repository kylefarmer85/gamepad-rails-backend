class User < ApplicationRecord
  has_secure_password
  validates :username, :email, uniqueness: true
  validates :username, :password, :email, :fav_genre, :fav_game, :photo, presence: true

  has_many :favorites, dependent: :destroy
  has_many :games, through: :favorites
  has_many :reviews, dependent: :destroy
  has_many :followers, dependent: :destroy
  has_many :followings, dependent: :destroy

  has_one_attached :photo

  # Will return an array of follows for the given user instance
  has_many :received_follows, foreign_key: :followed_user_id, class_name: "Follow"

  # Will return an array of users who follow the user instance
  has_many :followers, through: :received_follows, source: :follower
  
  
  # returns an array of follows a user gave to someone else
  has_many :given_follows, foreign_key: :follower_id, class_name: "Follow"
  
  # returns an array of other users who the user has followed
  has_many :followings, through: :given_follows, source: :followed_user


  def highest_rated_by_user_followings
  f_reviews = []
    self.followings.each do |f| 
      f.reviews.each{|r| f_reviews << r}
    end

  games_hash = {}
    f_reviews.each do |review|
        if review.rating > 0
            games_hash[review.game] = review.game.avg_rating
        end          
    end
  hash = games_hash.sort_by {|k,v| -v}.to_h
  return hash.keys
  end


end
