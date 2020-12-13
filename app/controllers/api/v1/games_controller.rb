class Api::V1::GamesController < ApplicationController

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

end
