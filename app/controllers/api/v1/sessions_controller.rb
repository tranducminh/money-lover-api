class Api::V1::SessionsController < ApplicationController
  def create
    @user = User.find_by(email: login_params[:email])

    if @user&.valid_password?(login_params[:password])
      token = JsonWebToken.encode({
        user_id: @user.id,
        jti: SecureRandom.uuid,
        exp: Time.now.to_i + ENV["token_expire_time"].to_i
      })
      response.headers['Authorization'] = "Bearer #{token}"
    else
      render_error :unauthorized, "Email or password is incorrect"
    end
  end

  def destroy
    response.headers.delete('Authorization')
  end

  private

  def login_params
    params.permit User::LOGIN_PARAMS
  end
end
