require 'test_helper'

class Store::OrderItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get store_order_items_show_url
    assert_response :success
  end

end
