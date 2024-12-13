class Admin::InvoicesController < ApplicationController
  layout "admin"
  before_action :set_invoice, only: %i[ show destroy ]
  before_action :require_login

  # GET /admin/invoices or /admin/invoices.json
  def index
    @invoices = Invoice.all

    if params[:order].present?
      @query = @query.order(params[:order])
    end

    @total_invoices_count = Invoice.count
    @filtered_invoices_count = @invoices.count

    @pagy, @invoices = pagy(@invoices)
  end

  # GET /admin/invoices/1 or /admin/invoices/1.json
  def show
  end

  # GET /admin/invoices/new
  def new
    @invoice = Invoice.new
    @invoice.items.build
  end

  # POST /admin/invoices or /admin/invoices.json
  def create
    @invoice = Invoice.new(invoice_params)

    respond_to do |format|
      if @invoice.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("new_invoice", partial: "invoices/success"),
            turbo_stream.remove("invoice_errors")
          ]
        end
        format.html { redirect_to @invoice, notice: "Invoice created successfully." }
      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("invoice_errors",
                                 partial: "shared/error_messages",
                                 locals: { object: @invoice }
            )
          ]
        end
        format.html { render :new }
      end
    end
  end

  # DELETE /admin/invoices/1 or /admin/invoices/1.json
  def destroy
    @invoice.destroy!

    respond_to do |format|
      format.html { redirect_to admin_invoices_path, status: :see_other, notice: "Invoice was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search_products
    @products = Product.by_name_or_description(params[:query])
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          "product_search_results",
          partial: "products/search_results",
          locals: { products: @products }
        )
      end
    end
  end

  def search_users
    @users = User.by_name_or_email(params[:query])

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          "user_search_results",
          partial: "users/search_results",
          locals: { users: @users }
        )
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params.expect(:id))
    end
    def invoice_params
      params.require(:invoice).permit(
        :user_id,
        invoice_items_attributes: [ :id, :product_id, :quantity, :_destroy ]
      )
    end
end
