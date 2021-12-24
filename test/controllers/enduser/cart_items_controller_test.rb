require 'test_helper'

class Enduser::CartItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get enduser_cart_items_index_url
    assert_response :success
  end

end
