class Api::V1::UserWalletsController < ApplicationController
  before_action :authenticate_request!
  before_action :find_wallet
  before_action :find_user_to_create, only: [:create]
  before_action :find_user_to_destroy, only: [:destroy]

  def index
    @user_wallets = @wallet.user_wallets
  end

  def create
    return render_error :bad_request, "Member is existed" if member_exist?

    case create_params[:user_role]
    when User::roles[:MANAGER]
      return render_error :forbidden, "Not allow to add manager" unless owner? @wallet.id

      create_user_wallet
    when User::roles[:OBSERVER]
      return render_error :forbidden, "Not allow to add observer" unless owner?(@wallet.id) || manager?(@wallet.id)

      create_user_wallet
    else
      render_error :forbidden, "Not allow to add member"
    end
  end

  def destroy
    return render_error :not_found, "Member is not existed" unless member_exist?

    case @member_wallet.user_role
    when User::roles[:MANAGER]
      return render_error :forbidden, "Not allow to delete manager" unless owner? @wallet.id

      @member_wallet.destroy
    when User::roles[:OBSERVER]
      return render_error :forbidden, "Not allow to delete observer" unless owner?(@wallet.id) || manager?(@wallet.id)

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

  def find_user_to_create
    @user = User.find_by(email: params[:email])

    render_error :not_found, "User with email #{params[:email]} not found" unless @user
  end

  def find_user_to_destroy
    @user = User.find(params[:id])

    render_error :not_found, "User id ##{params[:id]} not found" unless @user
  end

  def member_exist?
    @member_wallet = UserWallet.find_by(user_id: @user[:id], wallet_id: @wallet[:id])
  end

  def create_params
    params.permit(UserWallet::CREATE_PARAMS).except(:email).merge(user_id: @user.id)
  end

  def destroy_params
    params.permit(UserWallet::DESTROY_PARAMS)
  end

  def create_user_wallet
    @user_wallet = UserWallet.new(create_params)
    
    render :create, status: :created if @user_wallet.save
  end
end
