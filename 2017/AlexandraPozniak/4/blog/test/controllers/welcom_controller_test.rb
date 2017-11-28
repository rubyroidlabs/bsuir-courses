require 'test_helper'

class WelcomControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get welcom_index_url
    assert_response :success
  end

end
