class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_product, only: [:show]

  def index
    @products = Product.includes(:category).recent.upcoming.reservation_quota
    @products = Product.search_by_date(params[:date]) unless params[:date].blank?

    if params[:category_id]
      @category = Category.where('id = ?', params[:category_id].downcase).first!
      @products = @products.where(category: @category)
    end
  end

  def show
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :available_at, :is_promoted, :user_id, 
        :category_id, :description, :employee, :price, :reservations_count, :reservation_slots)
    end
end
