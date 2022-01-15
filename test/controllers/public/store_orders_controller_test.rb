require 'test_helper'

class Public::StoreOrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_store_orders_index_url
    assert_response :success
  end

  test "should get show" do
    get public_store_orders_show_url
    assert_response :success
  end

end
