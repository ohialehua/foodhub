require 'test_helper'

class Store::MarkersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_markers_index_url
    assert_response :success
  end

end
