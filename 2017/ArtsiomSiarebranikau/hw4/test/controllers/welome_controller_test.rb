require 'test_helper'

class WelomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get welome_index_url
    assert_response :success
  end

end
