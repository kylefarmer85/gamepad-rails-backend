class User < ApplicationRecord
  has_secure_password
  has_many :favorites
  has_many :games, through: :favorites
  has_many :reviews
end
