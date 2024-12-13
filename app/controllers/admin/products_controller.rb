class Admin::ProductsController < ApplicationController
  include Pundit::Authorization
  layout "admin"
  before_action :set_admin_product, only: %i[ show edit update destroy update_stock publish hide add_images destroy_image ]
  before_action :require_login

  # GET /admin/products or /admin/products.json
  def index
    @products = Product.all
    authorize Product
    params[:deleted] = false unless params[:deleted].present?
    @products= @products.by_name_or_description(params[:query]) if params[:query].present?
    @products = @products.deleted_ones(params[:deleted])

    @total_products_count = Product.all.count
    @total_products_published = Product.published_count
    @total_products_deleted = Product.deleted_count
    @pagy, @products = pagy(@products)
  end

  # GET /admin/products/1 or /admin/products/1.json
  def show
    authorize @product
  end

  # GET /admin/products/new
  def new
    @product = Product.new
    authorize @product
  end

  # GET /admin/products/1/edit
  def edit
    authorize @product
  end

  # POST /admin/products or /admin/products.json
  def create
    authorize Product
    category_ids = params.dig(:product, :categories)&.reject(&:blank?)
    product_params = admin_product_params.except(:categories)
    @product = Product.new(product_params)
    @product.category_ids = category_ids if category_ids.present?
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
    authorize @product
    category_ids = params.dig(:product, :categories)&.reject(&:blank?)
    product_params = admin_product_params.except(:categories)

    respond_to do |format|
      if @product.update(product_params)
        @product.category_ids = category_ids if category_ids.present?

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
    authorize @product
    @product.delete

    respond_to do |format|
      format.html { redirect_to admin_products_path, status: :see_other, notice: "Product was successfully deleted." }
      format.json { head :no_content }
    end
  end

  def update_stock
    authorize @product
    if @product.update(stock_quantity: params[:stock_quantity])
      render :show
    else
      @product.errors.clear unless request.patch?
      render partial: "admin/products/shared/update_stock", locals: { product: @product }
    end
  end

  def add_images
    authorize @product
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
    authorize @product
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
    authorize @product
    if @product.update(published: true)
      flash[:notice] = "Product published successfully"
      redirect_to admin_product_path @product
    else
      render :show
    end
  end

  def hide
    authorize @product
    if @product.update(published: false)
      flash[:notice] = "Product hidden successfully"
      redirect_to admin_product_path @product
    else
      render :show
    end
  end

  def search
    authorize Product
    @products = Product.by_name_or_description(params[:query])
    @products = @products.where(deleted: false).limit(5)

    render(
      partial: "admin/products/shared/search_results",
      formats: [ :turbo_stream ]
    )
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
        :color,
        :sizes_available,
        images: [],
        categories: [],
      )
    end
end
