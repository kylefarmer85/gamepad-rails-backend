class Api::V1::ReviewsController < ApplicationController

  def game_reviews_all
    game_api_id = params[:game_api_id]
    games = Game.all
    found_game = games.find_by(game_api_id: game_api_id)
    if found_game 
      render json: {game_reviews: found_game.reviews}
    else 
      render json: { error: "No Reviews Yet" }
    end
  end
end
