class Api::V1::UsersController < ApplicationController
  before_action :authenticate_request!, only: [:me]

  def create
    @user = User.new(user_params)

    @user.transaction do
      @user.save!
      @user.teams.create!(name: "Personal")
      token = JsonWebToken.encode({
        user_id: @user.id,
        jti: SecureRandom.uuid,
        exp: Time.now.to_i + ENV["token_expire_time"].to_i
      })
      @token = response.headers['Authorization'] = "Bearer #{token}"
    end

    if @user.errors.blank?
      render :create, status: :created
    else
      render_error :bad_request, @user.errors.full_messages
    end
  end

  def me
    @user = current_user
  end

  private

  def user_params
    params.permit User::USER_PARAMS
  end
end
