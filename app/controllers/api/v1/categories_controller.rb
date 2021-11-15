class Api::V1::CategoriesController < ApplicationController
  before_action :authenticate_request!
  before_action :find_wallet
  before_action :find_category, only: [:show, :update]

  def index
    return render_error :forbidden, "Not allow to get categories" unless accessible? @wallet.id

    @categories = @wallet.categories
  end

  def show
    render_error :forbidden, "Not allow to get categories" unless accessible? @wallet.id
  end

  def create
    return render_error :forbidden, "Not allow to create category" unless owner?(@wallet.id) || manager?(@wallet.id)

    @category = @wallet.categories.create!(create_params)
  end

  def update
    return render_error :forbidden, "Not allow to update category" unless owner?(@wallet.id) || manager?(@wallet.id)

    @category.update!(update_params)
  end

  private

  def find_wallet
    @wallet = Wallet.find(params[:wallet_id])
  end

  def find_category
    @category = @wallet.categories.find(params[:id])
  end

  def create_params
    params.permit(Category::CREATE_PARAMS)
  end

  def update_params
    params.permit(Category::UPDATE_PARAMS)
  end
end
