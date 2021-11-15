class Api::V1::UsersController < ApplicationController
  def create
    @user = User.create(user_params)

    if @user.errors.blank?
      render :create, status: :created
    else
      render_error :bad_request, @user.errors.full_messages
    end
  end

  private

  def user_params
    params.permit User::USER_PARAMS
  end
end
