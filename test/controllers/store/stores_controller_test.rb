require 'test_helper'

class Store::StoresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_stores_index_url
    assert_response :success
  end

  test "should get show" do
    get store_stores_show_url
    assert_response :success
  end

  test "should get edit" do
    get store_stores_edit_url
    assert_response :success
  end

  test "should get unsubscribe" do
    get store_stores_unsubscribe_url
    assert_response :success
  end

end
