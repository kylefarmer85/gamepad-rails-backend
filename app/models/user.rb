class User < ApplicationRecord
  has_secure_password
  has_many :favorites, dependent: :destroy
  has_many :games, through: :favorites
  has_many :reviews, dependent: :destroy
end
