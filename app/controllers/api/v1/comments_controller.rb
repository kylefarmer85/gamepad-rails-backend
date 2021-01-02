class Api::V1::CommentsController < ApplicationController

  def create

    comment = Comment.create(user_id: params[:user_id], review_id: params[:review_id], content: params[:content], username: params[:username], user_pic: params[:user_pic], review_username: params[:review_username], review_user_id: params[:review_user_id], game_api_id: params[:game_api_id], game_name: params[:game_name])

    render json: {id: comment.id, user_id: comment.user_id, review_id: comment.review_id, content: comment.content, username: comment.username, user_pic: comment.user_pic, review_username: comment.review_username, review_user_id: comment.review_user_id, game_name: comment.game_name, created_at: comment.created_at }
  end

end
