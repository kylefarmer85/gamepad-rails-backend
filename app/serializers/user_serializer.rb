class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  has_many :favorites
  has_many :games, through: :favorites
  has_many :reviews

  has_many :comments

  has_many :received_follows, foreign_key: :followed_user_id, class_name: "Follow"

  has_many :followers, through: :received_follows, source: :follower

  has_many :given_follows, foreign_key: :follower_id, class_name: "Follow"
  
  has_many :followings, through: :given_follows, source: :followed_user


  attributes :id, :username, :email, :fav_genre, :fav_game, :fav_console, :photo 

  def photo
    rails_blob_path(object.photo, only_path: true) if object.photo.attached?
  end

end

