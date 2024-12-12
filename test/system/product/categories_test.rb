require "application_system_test_case"

class Product::CategoriesTest < ApplicationSystemTestCase
  setup do
    @product_category = product_categories(:one)
  end

  test "visiting the index" do
    visit product_categories_url
    assert_selector "h1", text: "Categories"
  end

  test "should create category" do
    visit product_categories_url
    click_on "New category"

    click_on "Create Category"

    assert_text "Category was successfully created"
    click_on "Back"
  end

  test "should update Category" do
    visit product_category_url(@product_category)
    click_on "Edit this category", match: :first

    click_on "Update Category"

    assert_text "Category was successfully updated"
    click_on "Back"
  end

  test "should destroy Category" do
    visit product_category_url(@product_category)
    click_on "Destroy this category", match: :first

    assert_text "Category was successfully destroyed"
  end
end
