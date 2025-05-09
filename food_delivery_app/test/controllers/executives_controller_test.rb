require "test_helper"

class ExecutivesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get executives_new_url
    assert_response :success
  end

  test "should get create" do
    get executives_create_url
    assert_response :success
  end

  test "should get show" do
    get executives_show_url
    assert_response :success
  end

  test "should get get_assigned_order" do
    get executives_get_assigned_order_url
    assert_response :success
  end

  test "should get pick_up" do
    get executives_pick_up_url
    assert_response :success
  end

  test "should get deliver" do
    get executives_deliver_url
    assert_response :success
  end
end
