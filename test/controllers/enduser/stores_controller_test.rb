require 'test_helper'

class Enduser::StoresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get enduser_stores_index_url
    assert_response :success
  end

  test "should get show" do
    get enduser_stores_show_url
    assert_response :success
  end

end
