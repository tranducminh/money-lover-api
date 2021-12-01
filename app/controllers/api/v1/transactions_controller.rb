class Api::V1::TransactionsController < ApplicationController
  before_action :authenticate_request!
  before_action :find_wallet
  before_action :find_transaction, only: [:show, :update, :destroy]

  def index
    return render_error :forbidden, "Not allow to get this transaction" unless accessible? @wallet.id

    @transactions = @wallet.transactions.where(
      date: Date.new(params[:year].to_i, params[:month].to_i , 1)..Date.civil(params[:year].to_i, params[:month].to_i, -1)
    ).order(date: :desc)
  end

  def show
    render_error :forbidden, "Not allow to get this transaction" unless accessible? @wallet.id
  end

  def create
    return render_error :forbidden, "Not allow to create transaction" unless owner?(@wallet.id) || manager?(@wallet.id)

    return render_error :forbidden, "The wallet is freezed now" if @wallet.is_freezed

    @wallet.transaction do
      category = @wallet.categories.find(create_params[:category_id])
      @wallet.transactions.new(create_params)
      @wallet.total = @wallet.total + transfer_amount(category[:main_type], create_params[:amount])
      @wallet.save!
    end
  end

  def update
    return render_error :forbidden, "Not allow to update transaction" unless owner?(@wallet.id) || manager?(@wallet.id)
    
    return render_error :forbidden, "The wallet is freezed now" if @wallet.is_freezed

    @transaction.transaction do
      @wallet.transaction do
        @wallet.total = @wallet.total - transfer_amount(@transaction.category[:main_type], @transaction[:amount])
        
        category = @wallet.categories.find(update_params[:category_id])
        @wallet.total = @wallet.total + transfer_amount(
          category[:main_type] || @transaction.category[:main_type], 
          update_params[:amount] || @transaction[:amount]
        )
        @wallet.save!
      end

      @transaction.update!(update_params)
    end
  end

  def destroy
    return render_error :forbidden, "Not allow to delete transaction" unless owner?(@wallet.id) || manager?(@wallet.id)
    
    return render_error :forbidden, "The wallet is freezed now" if @wallet.is_freezed

    @transaction.transaction do
      @wallet.transaction do
        @wallet.total = @wallet.total - transfer_amount(@transaction.category[:main_type], @transaction[:amount])
        @wallet.save!
      end

      @transaction.destroy
    end
  end

  private

  def find_wallet
    @wallet = Wallet.find(params[:wallet_id])
  end

  def find_transaction
    @transaction = @wallet.transactions.find(params[:id])
  end

  def transfer_amount type, amount
    Category::INCOME_TYPES.include?(type) ? amount.abs : - amount.abs
  end

  def create_params
    params.permit(Transaction::CREATE_PARAMS)
  end

  def update_params
    params.permit(Transaction::UPDATE_PARAMS)
  end
end
