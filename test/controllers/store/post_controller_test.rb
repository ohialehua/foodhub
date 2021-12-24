require 'test_helper'

class Store::PostControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_post_index_url
    assert_response :success
  end

  test "should get show" do
    get store_post_show_url
    assert_response :success
  end

end
