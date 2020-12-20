class Api::V1::AuthController < ApplicationController

  def create
    user = User.find_by(username: params[:username].downcase)
    
    if user && user.authenticate(params[:password])
      payload = { user_id: user.id }

      token = JWT.encode(payload, 'my_secret', 'HS256')

      render json: { user: {id: user.id, username: user.username, email: user.email, pic: user.pic, fav_genre: user.fav_genre, fav_game: user.fav_game }, games: user.games, reviews: user.reviews, following: user.followings, followers: user.followers, token: token}
    else
      render json: { error: user.errors.full_messages }, status: 401
    end
  end


  def show
    token = request.headers[:Authorization].split(' ')[1]
    decoded_token = JWT.decode(token, 'my_secret' , true, { algorithm: 'HS256' })
    user_id = decoded_token[0]['user_id']
    user = User.find(user_id)

    render json: { user: {id: user.id, username: user.username, email: user.email, pic: user.pic, fav_genre: user.fav_genre, fav_game: user.fav_game }, games: user.games, reviews: user.reviews, following: user.followings, followers: user.followers, token: token}
  end
end

# { user: {id: user.id, username: user.username, email: user.email, pic: user.pic, fav_genre: user.fav_genre, fav_game: user.fav_game }, games: user.games, reviews: user.reviews}