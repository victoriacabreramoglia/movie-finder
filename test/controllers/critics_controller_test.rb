require 'test_helper'

class CriticsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get critics_index_url
    assert_response :success
  end

  test "should get show" do
    get critics_show_url
    assert_response :success
  end

end
