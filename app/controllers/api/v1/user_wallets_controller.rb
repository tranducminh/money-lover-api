class Api::V1::UserWalletsController < ApplicationController
  before_action :authenticate_request!
  before_action :find_wallet

  def create
    return render_error :bad_request, "Member is existed" if member_exist?

    case create_params[:user_role]
    when User::roles[:MANAGER]
      return render_error :forbidden, "Not allow to add manager" unless owner?

      create_user_wallet
    when User::roles[:OBSERVER]
      return render_error :forbidden, "Not allow to add observer" unless owner? || manager?

      create_user_wallet
    else
      render_error :forbidden, "Not allow to add member"
    end
  end

  def destroy
    return render_error :not_found, "Member is not existed" unless member_exist?

    case @member_wallet.user_role
    when User::roles[:MANAGER]
      return render_error :forbidden, "Not allow to delete manager" unless owner?

      @member_wallet.destroy
    when User::roles[:OBSERVER]
      return render_error :forbidden, "Not allow to delete observer" unless owner? || manager?

      @member_wallet.destroy
    else
      render_error :forbidden, "Not allow to delete member"
    end
  end

  private

  def find_wallet
    @wallet = Wallet.find_by(id: params[:wallet_id])

    render_error :not_found, "Wallet ##{params[:wallet_id]} not found" unless @wallet
  end

  def member_exist?
    @member_wallet = UserWallet.find_by(user_id: params[:user_id], wallet_id: params[:wallet_id])
  end

  def owner?
    UserWallet.find_by(user_id: current_user.id, wallet_id: @wallet.id, user_role: User::roles[:OWNER])
  end

  def manager?
    UserWallet.find_by(user_id: current_user.id, wallet_id: @wallet.id, user_role: User::roles[:MANAGER])
  end

  def create_params
    params.permit(UserWallet::CREATE_PARAMS)
  end

  def destroy_params
    params.permit(UserWallet::DESTROY_PARAMS)
  end

  def create_user_wallet
    @user_wallet = UserWallet.new(create_params)
    
    render :create, status: :created if @user_wallet.save
  end
end
