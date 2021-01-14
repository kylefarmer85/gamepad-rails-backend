class WelcomeController < ApplicationController
  def index
    render json: {name: 'foo'}
  end
end
