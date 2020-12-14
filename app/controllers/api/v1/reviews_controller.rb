class Api::V1::ReviewsController < ApplicationController

  def game_reviews_all
    game_api_id = params[:game_api_id]
    found_game = games.find_by (:game_api_id: game.game_api_id)
  end
end
