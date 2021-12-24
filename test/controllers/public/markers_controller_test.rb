require 'test_helper'

class Public::MarkersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_markers_index_url
    assert_response :success
  end

end
