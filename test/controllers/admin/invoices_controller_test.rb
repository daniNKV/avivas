require "test_helper"

class Admin::InvoicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @invoice = invoices(:one)
  end

  test "should get index" do
    get admin_invoices_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_invoice_url
    assert_response :success
  end

  test "should create invoice" do
    assert_difference("Invoice.count") do
      post admin_invoices_url, params: { invoice: {} }
    end

    assert_redirected_to admin_invoice_url(Invoice.last)
  end

  test "should show invoice" do
    get admin_invoice_url(@invoice)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_invoice_url(@invoice)
    assert_response :success
  end

  test "should update invoice" do
    patch admin_invoice_url(@invoice), params: { invoice: {} }
    assert_redirected_to admin_invoice_url(@invoice)
  end

  test "should destroy invoice" do
    assert_difference("Invoice.count", -1) do
      delete admin_invoice_url(@invoice)
    end

    assert_redirected_to admin_invoices_url
  end
end
