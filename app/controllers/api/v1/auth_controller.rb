class Api::V1::AuthController < ApplicationController
  include Rails.application.routes.url_helpers

  def create

    user = User.find_by(username: params[:username].downcase)
    
    if user && user.authenticate(params[:password])
      payload = { user_id: user.id }

      token = JWT.encode(payload, 'my_secret', 'HS256')

      render json: { user: {id: user.id, username: user.username, email: user.email, fav_genre: user.fav_genre, fav_game: user.fav_game, fav_console: user.fav_console, photo: rails_blob_path(user.photo, disposition: "attachment") }, games: user.games, following: user.followings, followers: user.followers, token: token}
    else

      render json: { error: "Invalid Username/Password" }
    end
  end


  def show

    token = request.headers[:Authorization].split(' ')[1]
    decoded_token = JWT.decode(token, 'my_secret' , true, { algorithm: 'HS256' })
    user_id = decoded_token[0]['user_id']
    user = User.find(user_id)

    render json: { user: {id: user.id, username: user.username, email: user.email, fav_genre: user.fav_genre, fav_game: user.fav_game, fav_console: user.fav_console, photo: rails_blob_path(user.photo, disposition: "attachment") }, games: user.games, following: user.followings, followers: user.followers, token: token}
  end

end
