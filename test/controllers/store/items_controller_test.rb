require 'test_helper'

class Store::ItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get store_items_new_url
    assert_response :success
  end

  test "should get index" do
    get store_items_index_url
    assert_response :success
  end

  test "should get edit" do
    get store_items_edit_url
    assert_response :success
  end

  test "should get show" do
    get store_items_show_url
    assert_response :success
  end

end
