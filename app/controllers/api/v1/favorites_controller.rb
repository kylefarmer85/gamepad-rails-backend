class Api::V1::FavoritesController < ApplicationController

  def remove
    favorite = Favorite.find_by!(user_id: params[:user_id], game_id: params[:game_id])
    
    favorite.destroy

    render json: favorite
  end

end
