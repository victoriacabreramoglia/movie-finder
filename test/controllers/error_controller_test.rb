require 'test_helper'

class ErrorControllerTest < ActionDispatch::IntegrationTest
  test "should get timeline" do
    get error_timeline_url
    assert_response :success
  end

end
