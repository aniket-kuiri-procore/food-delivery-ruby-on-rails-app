require "test_helper"

class RestaurantsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get restaurants_new_url
    assert_response :success
  end

  test "should get create" do
    get restaurants_create_url
    assert_response :success
  end

  test "should get show" do
    get restaurants_show_url
    assert_response :success
  end

  test "should get add_food_item" do
    get restaurants_add_food_item_url
    assert_response :success
  end

  test "should get pending_orders" do
    get restaurants_pending_orders_url
    assert_response :success
  end

  test "should get confirm_order" do
    get restaurants_confirm_order_url
    assert_response :success
  end

  test "should get reject_order" do
    get restaurants_reject_order_url
    assert_response :success
  end
end
