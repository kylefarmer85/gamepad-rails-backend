class ReviewSerializer < ActiveModel::Serializer
  belongs_to :user
  belongs_to :game

  attributes :id
end
