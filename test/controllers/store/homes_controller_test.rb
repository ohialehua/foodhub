require 'test_helper'

class Store::HomesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get store_homes_top_url
    assert_response :success
  end

end
