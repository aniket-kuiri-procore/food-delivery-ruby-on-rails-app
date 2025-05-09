require "test_helper"

class ExecutiveControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get executive_new_url
    assert_response :success
  end

  test "should get create" do
    get executive_create_url
    assert_response :success
  end

  test "should get show" do
    get executive_show_url
    assert_response :success
  end

  test "should get get_assigned_order" do
    get executive_get_assigned_order_url
    assert_response :success
  end

  test "should get pick_up" do
    get executive_pick_up_url
    assert_response :success
  end

  test "should get deliver" do
    get executive_deliver_url
    assert_response :success
  end
end
