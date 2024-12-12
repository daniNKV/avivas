class Admin::ProductsController < ApplicationController
  layout "admin"
  before_action :set_admin_product, only: %i[ show edit update destroy update_stock publish hide add_images destroy_image ]
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
      if set_admin_product.update(admin_product_params)
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

  def update_stock
    if @product.update(stock_quantity: params[:stock_quantity])
      render :show
    else
      @product.errors.clear unless request.patch?
      render partial: "admin/products/shared/update_stock", locals: { product: @product }
    end
  end

  def add_images
    if params[:images].present?
      params[:images].each do |image|
        @product.attachment.attach(image)
      end
      flash[:notice] = "Images uploaded successfully"
      redirect_to admin_product_path(@product)
    else
      @product.errors.clear unless request.patch?
      render partial: "admin/products/shared/image_form", locals: { product: @product }
    end
  end

  def destroy_image
    image = @product.images.find(params[:image_id])
    if image.purge
      flash[:notice] = "Image deleted successfully"
      redirect_to admin_product_path(@product)
    else
      flash[:notice] = "Image could not be deleted"
      redirect_to admin_product_path(@product)
    end
  end

  def publish
    if @product.update(published: true)
      flash[:notice] = "Product published successfully"
      redirect_to admin_product_path @product
    else
      render :show
    end
  end

  def hide
    if @product.update(published: false)
      flash[:notice] = "Product hidden successfully"
      redirect_to admin_product_path @product
    else
      render :show
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
        :image,
        images: [],
        categories: [],
      )
    end
end
