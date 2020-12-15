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
    user_id = params[:user_id]
    username = params[:username]
    content = params[:content]
    rating = params[:content]
    game_name = params[:game_name]
    game_api_id = params[:game_api_id]
    game_image = params[:game_image]

    games = Game.all
    found_game = games.find_by(game_api_id: game_api_id)

    #if game in db create a review with it's game id
    if found_game 
      review = Review.create(user_id: user_id, game_id: found_game.id, game_name: game_name, content: content, rating: rating, username: username)   

      render json: review

    #else create a new game in db, and then use the game id for the new review  
    else 
      new_game = Game.create(game_name: game_name, game_image: game_image, game_api_id: game_api_id)    

      review = Review.create(user_id: user_id, game_id: new_game.id, game_name: game_name, content: content, rating: rating, username: username)

      render json: review
    end
  end


  def destroy
    review = Review.find(params[:id])
    review.destroy

    render json: review
  end

end
