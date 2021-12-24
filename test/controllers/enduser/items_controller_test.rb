require 'test_helper'

class Enduser::ItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get enduser_items_index_url
    assert_response :success
  end

  test "should get show" do
    get enduser_items_show_url
    assert_response :success
  end

end
