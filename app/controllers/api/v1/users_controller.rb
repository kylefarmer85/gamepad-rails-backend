class Api::V1::UsersController < ApplicationController

  def index
    users = User.all
    render json: users
  end


  def show
    user = User.find(params[:id])
    if user
      render json: user

    else  
      render json: {error: user.errors.full_messages}, status: 401
    end
  end


  def create
    user = User.create(username: params[:username].downcase, password: params[:password], password_confirmation: params[:password_confirmation], email: params[:email], pic: params[:pic], fav_genre: params[:fav_genre], fav_game: params[:fav_game])
    
    if user.save
      payload = { user_id: user.id }
      token = JWT.encode(payload, 'my_secret', 'HS256')
        render json: { user: {id: user.id, username: user.username, email: user.email, pic: user.pic, fav_genre: user.fav_genre, fav_game: user.fav_game}, games: user.games, reviews: user.reviews, following: user.followings, followers: user.followers, token: token }
    else
        render json: {error: user.errors.full_messages}, status: 401
    end
  end


  def update
    user = User.find(params[:id])
    user.assign_attributes(user_params)
  
    if user.valid?      
        user.save
        render json: user
    else
        render json: {error: user.errors.full_messages}, status: 401
    end
  end


  def following
    followed_user = User.find(params[:followed_user_id])
    new_follow = Follow.create(follower_id: params[:follower_id], followed_user_id: followed_user.id)
    
    if new_follow.valid?
      render json: followed_user
    else 
      render json: {error: new_follow.errors.full_messages}, status: 401
    end
  end


  def unfollow
    follow_to_destroy = Follow.find_by(follower_id: params[:follower_id], followed_user_id: params[:followed_user_id])
    follow_to_destroy.destroy

    unfollowed_user = User.find(params[:followed_user_id])
    render json: {id: unfollowed_user.id , username: unfollowed_user.username}
  end


  def search
    search_term = params[:search_term].downcase
    user = User.where("username like ?", search_term)

    if user
      render json: user[0].id
    else 
      render json: {error: user.errors.full_messages}, status: 401
    end
  end


  def destroy
    user = User.find(params[:id])
    user.destroy

    render json: user
  end


  def user_params
    params.require(:user).permit(:username, :password, :password, :password_confirmation, :email, :pic, :fav_genre, :fav_game)
  end
end
