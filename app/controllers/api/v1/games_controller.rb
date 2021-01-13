class Api::V1::GamesController < ApplicationController

  def show

    game_api_id = params[:id]
    key = ENV["RAWG_API_KEY"]
    url = "https://api.rawg.io/api/games/#{game_api_id}"
    url_ss = "https://api.rawg.io/api/games/#{game_api_id}/screenshots"

    response = RestClient.get(url, headers = {
      'Content-Type': 'application/json',
      'User-Agent': 'Kyle Farmer Coding Bootcamp Project',
      'token': key
    })

    response_ss = RestClient.get(url_ss, headers = {
      'Content-Type': 'application/json',
      'User-Agent': 'Kyle Farmer Coding Bootcamp Project',
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
      'User-Agent': 'Kyle Farmer Coding Bootcamp Project',
      'token': key
    })

    search_results = JSON.parse(response)
    render json: search_results
  end


  def console_and_genre

    console_list = {
      'Atari 2600': 23,
      'Atari 5200': 31,
      'Atari 7800': 28,
      'Nintendo Entertainment System': 49,
      'Sega Master System': 74,
      'Sega Genesis': 167,
      'Neo Geo': 12,
      'Game Boy': 26,
      'Game Gear': 77,
      'Super Nintendo': 79,
      'Sega CD': 119,
      'Atari Jaguar': 112,
      'Panasonic 3DO': 111,
      'Sega 32X': 117,
      'Sega Saturn': 107,
      'PlayStation': 27,
      'Nintendo 64': 83,
      'Game Boy Color': 43,
      'Dreamcast': 106,
      }
    
    #converts the selected console to an id for the api  
    console = params[:console]
    console_id = console_list[:"#{console}"]
    
    genre = params[:genre].sub(/^[A-Z]/) {|f| f.downcase }
   
    # rpg has to go into the api query like this  
    if genre === "rPG"
      genre = "role-playing-games-rpg"
    end  

    key =  key = ENV["RAWG_API_KEY"]
      
    url = "https://api.rawg.io/api/games?genres=#{genre}&platforms=#{console_id}&page_size=100"

    response = RestClient.get(url, headers = {
      'Content-Type': 'application/json',
      'User-Agent': 'Kyle Farmer Coding Bootcamp Project',
      'token': key
    })

    console_and_genre_results = JSON.parse(response)
    render json: console_and_genre_results
  end


  def year_and_genre

    year = params[:year]
    genre = params[:genre].sub(/^[A-Z]/) {|f| f.downcase }
   
    # rpg has to go into the api query like this  
    if genre === "rPG"
      genre = "role-playing-games-rpg"
    end  

    key =  key = ENV["RAWG_API_KEY"]
    url = "https://api.rawg.io/api/games?dates=#{year}-01-01,#{year}-12-31&genres=#{genre}&platforms=23,31,28,49,74,26,167,77,43,119,79,112,117,111,12,107,27,83,106&page_size=100"

    response = RestClient.get(url, headers = {
      'Content-Type': 'application/json',
      'User-Agent': 'Kyle Farmer Coding Bootcamp Project',
      'token': key
    })

    year_and_genre_results = JSON.parse(response)
    render json: year_and_genre_results
  end
  

  def top_by_console

    console_list = {
      'Atari 2600': 23,
      'Atari 5200': 31,
      'Atari 7800': 28,
      'Nintendo Entertainment System': 49,
      'Sega Master System': 74,
      'Sega Genesis': 167,
      'Neo Geo': 12,
      'Game Boy': 26,
      'Game Gear': 77,
      'Super Nintendo': 79,
      'Sega CD': 119,
      'Atari Jaguar': 112,
      'Panasonic 3DO': 111,
      'Sega 32X': 117,
      'Sega Saturn': 107,
      'PlayStation': 27,
      'Nintendo 64': 83,
      'Game Boy Color': 43,
      'Dreamcast': 106,
      }

    #converts the selected console to an id for the api  
    console = params[:console]
    console_id = console_list[:"#{console}"]

    key =  key = ENV["RAWG_API_KEY"]
    url = "https://rawg.io/api/games?ordering=-rating&platforms=#{console_id}&page_size=100"

    response = RestClient.get(url, headers ={
      'Content-Type': 'application/json',
      'User-Agent': 'Kyle Farmer Coding Bootcamp Project',
      'token': key
    })

    top_by_console_results = JSON.parse(response)
    render json: top_by_console_results
  end


  def highest_rated_by_followings

    user = User.find(params[:id])
    games = user.highest_rated_by_user_followings

    render json: games
  end


  def favorites
    user_id = params[:user_id]
    game_api_id = params[:game_api_id]
    game_name = params[:game_name]
    game_image = params[:game_image]

    #checks if game is in db 
    games = Game.all
    found_game = games.find_by(game_api_id: game_api_id)

    #if so we create a new favorit with user and game ids
    if found_game
      Favorite.create(user_id: user_id, game_id: found_game.id)
      
      render json: {id: found_game.id, name: found_game.name, image: found_game.image, game_api_id: found_game.game_api_id}

    #if game is not in db, we create a game obj and then create a new favorite with user and game ids
    else
      new_game = Game.create(name: game_name, image: game_image, game_api_id: game_api_id)
      Favorite.create(user_id: user_id, game_id: new_game.id)

      render json: {id: new_game.id, name: new_game.name, image: new_game.image, game_api_id: new_game.game_api_id}
    end
  end

end
