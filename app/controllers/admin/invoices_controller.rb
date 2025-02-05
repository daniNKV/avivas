class Admin::InvoicesController < ApplicationController
  include Pundit::Authorization
  layout "admin"
  before_action :set_invoice, only: %i[ show cancel ]
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

  def create
    authorize Invoice
    @invoice = Invoice.new(invoice_params)
    Rails.logger.debug("Invoice params: #{invoice_params.inspect}")
    success = false
  
    ActiveRecord::Base.transaction do
      if @invoice.save
        insufficient_stock = []
  
        @invoice.items.each do |item|
          product = item.product
          product.reload(lock: true) 
  
          if product.stock_quantity < item.units
            insufficient_stock << product.name
          end
        end
  
        if insufficient_stock.any?
          flash[:alert] = "Insufficient stock for: #{insufficient_stock.join(', ')}"
          raise ActiveRecord::Rollback
        end
  
        @invoice.items.each do |item|
          product = item.product
          product.update!(stock_quantity: product.stock_quantity - item.units)
        end
  
        success = true
        
      else
        flash[:alert] = "Unable to save invoice: #{@invoice.errors.full_messages.join(', ')}"
        raise ActiveRecord::Rollback
      end
    end
  
    if success
      redirect_to [:admin, @invoice], notice: "Invoice was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end


  # PATCH /admin/invoices/:id/cancel
  def cancel
    authorize @invoice
    Rails.logger.debug "Canceling invoice #{@invoice.id}..."
  
    if @invoice.cancel!
      redirect_to [:admin, @invoice], notice: "Invoice was successfully canceled."
    else
      Rails.logger.error "Failed to cancel invoice: #{@invoice.errors.full_messages.join(', ')}"
      redirect_to [:admin, @invoice], alert: "Unable to cancel the invoice: #{@invoice.errors.full_messages.join(', ')}"
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
        :user_id,
        items_attributes: [:product_id, :units, :price, :_destroy]
      )
    end
end
