require 'test_helper'

class Enduser::CouponsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get enduser_coupons_index_url
    assert_response :success
  end

  test "should get show" do
    get enduser_coupons_show_url
    assert_response :success
  end

end
