class Api::V1::UsersController < ApplicationController

  def index
    users = User.all
    render json: users
  end

  def create
    
    user = User.create(username: params[:username], password: params[:password], password_confirmation: params[:password_confirmation], email: params[:email], pic: params[:pic], fav_genre: params[:fav_genre], fav_game: params[:fav_game])
    
    if user.save
      payload = { user_id: user.id }
      token = JWT.encode(payload, 'my_secret', 'HS256')
        render json: { user: user, token: token}
    else
        render json: {error: user.errors.full_messages}, status: 401
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy

    render json: user
  end

end
