class Api::V1::ReviewsController < ApplicationController

  def reviews_all
    game_api_id = params[:game_api_id]
    games = Game.all
    found_game = games.find_by(game_api_id: game_api_id)

    #this will send null to FE if game isn't already in database or isbut has no reviews
    if found_game && found_game.reviews.length > 0 
      render json: found_game.reviews
    else 
      render json: nil
    end
  end

  def create
    review = Review.new(review_params)
    review.assign_attributes(note_params)

    if review.valid?
      review.save
      render json: review
    else
      render json: review.errors.full_messages
    end
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy

    render json: review
  end

  private

  def review_params
    params.require(:review).permit(:user_id, :game_id, :content, :rating, :username, :game_name)
  end

end
