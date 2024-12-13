class Admin::InvoicesController < ApplicationController
  layout "admin"
  before_action :set_invoice, only: %i[ show  destroy ]

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
  end

  # POST /admin/invoices or /admin/invoices.json
  def create
    @invoice = Invoice.new(invoice_params)

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to [:admin, @invoice], notice: "Invoice was successfully created." }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def invoice_params
      params.fetch(:invoice, {})
    end
end
