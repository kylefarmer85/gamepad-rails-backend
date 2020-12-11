class Api::V1::UsersController < ApplicationController

  def show
    user = User.find(1)
    render json: user
  end
end
