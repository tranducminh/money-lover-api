class Api::V1::WalletsController < ApplicationController
  before_action :authenticate_request!
  before_action :find_wallet, only: [:show, :update, :destroy]

  def index
    @wallets = []
    current_user.user_wallets.each do |user_wallet|
      @wallets.push(user_wallet.wallet)
    end
    render :index, status: :ok
  end

  def create
    @wallet = Wallet.new(create_params)

    if @wallet.save
      UserWallet.create(
        user_id: current_user.id,
        wallet_id: @wallet.id,
        user_role: User::roles[:OWNER]
      )

      render :create, status: :created
    else
      render_error :bad_request, "Create wallet failed"
    end
  end

  def show
    if accessible?
      render :show, status: :ok
    else
      render_error :forbidden, "Not allow to access this wallet"
    end
  end

  def update
    if owner?
      @wallet.update(update_params)
      render :update, status: :ok
    else
      render_error :forbidden, "Not allow to update this wallet"
    end
  end

  def destroy
    if owner?
      @wallet.destroy
    else
      render_error :forbidden, "Not allow to delete this wallet"
    end
  end

  private

  def create_params
    params.permit(Wallet::CREATE_PARAMS)
  end

  def update_params
    params.permit(Wallet::UPDATE_PARAMS)
  end

  def find_wallet
    @wallet = Wallet.find_by(id: params[:id])

    render_error :not_found, "Wallet ##{params[:id]} not found" unless @wallet
  end

  def owner?
    UserWallet.find_by(user_id: current_user.id, wallet_id: @wallet.id, user_role: User::roles[:OWNER])
  end

  def accessible?
    UserWallet.find_by(user_id: current_user.id, wallet_id: @wallet.id)
  end
end
