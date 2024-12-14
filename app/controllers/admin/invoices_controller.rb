class Admin::InvoicesController < ApplicationController
  include Pundit::Authorization
  layout "admin"
  before_action :set_invoice, only: %i[ show destroy ]
  before_action :require_login

  # GET /admin/invoices or /admin/invoices.json
  def index
    authorize Invoice
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
    authorize @invoice
  end

  # GET /admin/invoices/new
  def new
    @invoice = Invoice.new
    authorize @invoice
    @invoice.items.build
  end

  # POST /admin/invoices or /admin/invoices.json
  def create
    authorize Invoice
    @user = User.find(params[:user_id]) if params[:user_id].present?
    puts params[:user_id]
    @invoice = Invoice.new(invoice_params)
    @invoice.user = params[:invoice][:user].to_i if params[:invoice][:user].present?

    if @invoice.save
      flash[:notice] = "Successfully created invoice."
      redirect_to [ :admin, @invoice ]
    else
      flash[:notice] = "Unable to save invoice."
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /admin/invoices/1 or /admin/invoices/1.json
  def destroy
    authorize @invoice
    @invoice.destroy!

    respond_to do |format|
      format.html { redirect_to admin_invoices_path, status: :see_other, notice: "Invoice was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params.expect(:id))
    end
    def invoice_params
      params.require(:invoice).permit(
        :transaction_date,
        :notes,
        :total_price,
        :user,
        :user_id,
        items_attributes: [ :product_id, :units, :_destroy ],
        products: {}
      )
    end
end
