require 'test_helper'

class Store::CouponsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get store_coupons_new_url
    assert_response :success
  end

  test "should get index" do
    get store_coupons_index_url
    assert_response :success
  end

  test "should get edit" do
    get store_coupons_edit_url
    assert_response :success
  end

end
