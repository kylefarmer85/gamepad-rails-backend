class Game < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites


  def avg_rating
    
    if reviews.count > 0
      sum = 0
      count = 0
      reviews.each do |r|
        unless r.rating.nil?
          sum += r.rating
          count += 1
        end
      end
      sum / count
    end
  end

end
