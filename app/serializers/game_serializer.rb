class GameSerializer < ActiveModel::Serializer
  has_many :reviews
  has_many :favorites
  has_many :users, through: :favorites
  
  attributes :id, :name, :image, :game_api_id
end
