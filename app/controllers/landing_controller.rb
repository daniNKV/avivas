class LandingController < ApplicationController
  before_action :set_categories
  def index
    @products = Product.published_products.order(created_at: :desc)
    if params[:category]
      @category = Product::Category.find(params[:category])
      @products = @category.products
    end
    @products = @products.by_name_or_description(params[:query]) if params[:query]
    @pagy, @products = pagy(@products)
    respond_to do |format|
      format.html # GET
      format.turbo_stream # POST
    end
  end
  def show
    @product = Product.find(params[:id])
  end

  private
  def set_categories
    @categories = Product::Category.all
  end
end
