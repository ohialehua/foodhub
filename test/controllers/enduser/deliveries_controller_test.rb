require 'test_helper'

class Enduser::DeliveriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get enduser_deliveries_index_url
    assert_response :success
  end

  test "should get edit" do
    get enduser_deliveries_edit_url
    assert_response :success
  end

end
