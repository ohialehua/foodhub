require 'test_helper'

class Store::OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get store_orders_show_url
    assert_response :success
  end

end
