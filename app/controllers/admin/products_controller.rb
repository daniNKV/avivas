class Admin::ProductsController < ApplicationController
  layout "admin"
  before_action :set_admin_product, only: %i[ show edit update destroy ]
  before_action :require_login
  # GET /admin/products or /admin/products.json
  def index
    @products = Product.all
    @products= @products.by_name_or_description(params[:query]) if params[:query].present?

    @pagy, @products = pagy(@products)
  end

  # GET /admin/products/1 or /admin/products/1.json
  def show
  end

  # GET /admin/products/new
  def new
    @product = Product.new
  end

  # GET /admin/products/1/edit
  def edit
  end

  # POST /admin/products or /admin/products.json
  def create
    @product = Product.new(admin_product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to admin_product_path @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/products/1 or /admin/products/1.json
  def update
    respond_to do |format|
      if @product.update(admin_product_params)
        format.html { redirect_to admin_product_path @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/products/1 or /admin/products/1.json
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to admin_products_path, status: :see_other, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_product
      @product = Product.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def admin_product_params
      params.require(:product).permit(
        :name,
        :description,
        :base_price,
        :stock_quantity,
        images: [],
      )
    end
end
