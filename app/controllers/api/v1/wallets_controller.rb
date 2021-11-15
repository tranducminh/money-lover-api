class Api::V1::WalletsController < ApplicationController
  before_action :authenticate_request!
  before_action :find_wallet, only: [:show, :update, :destroy]

  def index
    @wallets = []
    current_user.user_wallets.each do |user_wallet|
      @wallets.push(user_wallet.wallet)
    end
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
    render_error :forbidden, "Not allow to access this wallet" unless accessible?
  end

  def update
    return render_error :forbidden, "Not allow to update this wallet" unless owner?

    @wallet.update!(update_params)
  end

  def destroy
    return render_error :forbidden, "Not allow to delete this wallet" unless owner?

    @wallet.destroy
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
