class Api::V1::GamesController < ApplicationController

  def show
    game_api_id = params[:id]
    key = ENV["RAWG_API_KEY"]
    url = "https://api.rawg.io/api/games/#{game_api_id}"
    url_ss = "https://api.rawg.io/api/games/#{game_api_id}/screenshots"

    response = RestClient.get(url, headers = {
      'Content-Type': 'application/json',
      'User-Agent': 'Coding Bootcamp Project',
      'token': key
    })

    response_ss = RestClient.get(url_ss, headers = {
      'Content-Type': 'application/json',
      'User-Agent': 'Coding Bootcamp Project',
      'token': key
    })

    game_obj = JSON.parse(response)
    game_ss = JSON.parse(response_ss)
    render json: { game_obj: game_obj, game_ss: game_ss}
  end


  def search
    search_term = params[:search_term]
    key = ENV["RAWG_API_KEY"]
    url = "https://api.rawg.io/api/games?search=#{search_term}&platforms=23,31,28,49,74,26,167,77,43,119,79,112,117,111,12,107,27,83,106"

    response = RestClient.get(url, headers ={
      'Content-Type': 'application/json',
      'User-Agent': 'Coding Bootcamp Project',
      'token': key
    })

    search_results = JSON.parse(response)
    render json: search_results
  end


  def favorites
    user_id = params[:user_id]
    game_api_id = params[:game_api_id]
    game_name = params[:game_name]
    game_image = params[:game_image]

    games = Game.all
    found_game = games.find {|game| game.game_api_id == game_api_id}
    
    if found_game
      Favorite.create(user_id: user_id, game_id: found_game.id)
    else
      new_game = Game.create(name: game_name, image: game_image, game_api_id: game_api_id)
      Favorite.create(user_id: user_id, game_id: new_game.id)
    end

    render json: {name: game_name, image: game_image, game_api_id: game_api_id}
  end
end
