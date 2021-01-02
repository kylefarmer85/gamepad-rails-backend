class Review < ApplicationRecord
  validates :content, :rating, presence: true

  has_many :comments, dependent: :destroy


  belongs_to :user
  belongs_to :game
end
