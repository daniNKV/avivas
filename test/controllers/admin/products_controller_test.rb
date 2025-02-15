require "test_helper"

class Admin::ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = admin_products(:one)
  end

  test "should get index" do
    get admin_products_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_product_url
    assert_response :success
  end

  test "should create admin_product" do
    assert_difference("Admin::Product.count") do
      post admin_products_url, params: { product: {} }
    end

    assert_redirected_to admin_product_url(Admin::Product.last)
  end

  test "should show admin_product" do
    get admin_product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_product_url(@product)
    assert_response :success
  end

  test "should update admin_product" do
    patch admin_product_url(@product), params: { product: {} }
    assert_redirected_to admin_product_url(@product)
  end

  test "should destroy admin_product" do
    assert_difference("Admin::Product.count", -1) do
      delete admin_product_url(@product)
    end

    assert_redirected_to admin_products_url
  end
end
