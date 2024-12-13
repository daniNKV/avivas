class Admin::Products::CategoriesController < ApplicationController
  layout "admin"
  before_action :set_product_category, only: %i[ edit update destroy ]
  before_action :require_login

  # GET /admin/products/categories or /admin/products/categories.json
  def index
    @product_category = Product::Category.new
    @product_categories = Product::Category.all
  end

  # GET /admin/products/categories/new
  def new
    @product_category = Product::Category.new
  end

  # GET /admin/products/categories/1/edit
  def edit
  end

  # POST /admin/products/categories or /admin/products/categories.json
  def create
    @product_category = Product::Category.new(product_category_params)

    respond_to do |format|
      if @product_category.save
        format.html { redirect_to admin_products_categories_path, notice: "Category was successfully created." }
        format.json { render :show, status: :created, location: @product_category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/products/categories/1 or /admin/products/categories/1.json
  def update
    respond_to do |format|
      if @product_category.update(product_category_params)
        format.html { redirect_to admin_products_categories_path, notice: "Category was successfully updated." }
        format.json { render :show, status: :ok, location: @product_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/products/categories/1 or /admin/products/categories/1.json
  def destroy
    @product_category.products.clear

    category = @product_category.name
    puts category
    @product_category.destroy!

    respond_to do |format|
      format.html { redirect_to admin_products_category_path, status: :see_other, notice: "Category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_category
      @product_category = Product::Category.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def product_category_params
      params.require(:product_category).permit(:name, :description, :active)
    end
end
