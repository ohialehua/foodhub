require 'test_helper'

class Store::GenresControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get store_genres_new_url
    assert_response :success
  end

  test "should get edit" do
    get store_genres_edit_url
    assert_response :success
  end

end
