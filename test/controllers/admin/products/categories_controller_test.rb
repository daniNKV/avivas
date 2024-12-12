require "test_helper"

class Admin::Products::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product_category = product_categories(:one)
  end

  test "should get index" do
    get admin_products_product_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_products_product_category_url
    assert_response :success
  end

  test "should create product_category" do
    assert_difference("Product::Category.count") do
      post admin_products_product_categories_url, params: { product_category: {} }
    end

    assert_redirected_to admin_products_product_category_url(Product::Category.last)
  end

  test "should show product_category" do
    get admin_products_product_category_url(@product_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_products_product_category_url(@product_category)
    assert_response :success
  end

  test "should update product_category" do
    patch admin_products_product_category_url(@product_category), params: { product_category: {} }
    assert_redirected_to admin_products_product_category_url(@product_category)
  end

  test "should destroy product_category" do
    assert_difference("Product::Category.count", -1) do
      delete admin_products_product_category_url(@product_category)
    end

    assert_redirected_to admin_products_product_categories_url
  end
end
