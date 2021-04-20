class Api::V1::AuthController < ApplicationController

  def create
    user = User.find_by(username: params[:username].downcase)
    
    if user && user.authenticate(params[:password])
      payload = { user_id: user.id }
      token = JWT.encode(payload, 'my_secret', 'HS256')

      render json: {user: UserSerializer.new(user), token: token}
    else
      render json: { error: "Invalid Username/Password" }
    end
  end


  def show
    token = request.headers[:Authorization].split(' ')[1]
    decoded_token = JWT.decode(token, 'my_secret' , true, { algorithm: 'HS256' })
    user_id = decoded_token[0]['user_id']
    user = User.find(user_id)

    render json: {user: UserSerializer.new(user), token: token}
  end

end
