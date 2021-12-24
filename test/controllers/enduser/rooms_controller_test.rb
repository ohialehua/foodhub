require 'test_helper'

class Enduser::RoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get enduser_rooms_index_url
    assert_response :success
  end

  test "should get show" do
    get enduser_rooms_show_url
    assert_response :success
  end

end
