class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  has_many :favorites
  has_many :games
  has_many :reviews
  has_many :comments
  has_many :followers
  has_many :followings

  attributes :id, :username, :email, :fav_genre, :fav_game, :fav_console, :photo 

  def photo
    rails_blob_path(object.photo, only_path: true) if object.photo.attached?
  end

end

