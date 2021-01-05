class Api::V1::UsersController < ApplicationController
  include Rails.application.routes.url_helpers

  def show

    user = User.find(params[:id])
    if user
      render json: user

    else  
      render json: {error: user.errors.full_messages}, status: 401
    end
  end


  def create

    params[:username].downcase
    user = User.create(user_params)
  
    if user.save
      payload = { user_id: user.id }
      token = JWT.encode(payload, 'my_secret', 'HS256')

      render json: { user: {id: user.id, username: user.username, email: user.email, fav_genre: user.fav_genre, fav_game: user.fav_game, fav_console: user.fav_console, photo: rails_blob_path(user.photo, disposition: "attachment")}, games: user.games, reviews: user.reviews, comments: user.comments, following: user.followings, followers: user.followers, token: token }
    else
      render json: {error: user.errors.full_messages}, status: 401
    end
  end


  def update

    user = User.find(params[:id])
    user.update(user_params)

    if user.valid?      
        user.save

        render json: {id: user.id, username: user.username, email: user.email, fav_genre: user.fav_genre, fav_game: user.fav_game, fav_console: user.fav_console, photo: rails_blob_path(user.photo, disposition: "attachment")}
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
    users = User.where("username like ?", '%' + search_term.first(3) + '%')

    if users
      # render json: user[0].id
      render json: users
    else 
      render json: {error: users.errors.full_messages}, status: 401
    end
  end



  def search_by_console_and_genre

    console = params[:console]
    genre = params[:genre]

    users = User.where(fav_console: console, fav_genre: genre)

    render json: users
  end


  def destroy

    user = User.find(params[:id])
    user.destroy

    render json: user
  end


  def user_params
    params.permit(:id, :username, :password, :password_confirmation, :email, :fav_genre, :fav_game, :photo, :fav_console)
  end
end
