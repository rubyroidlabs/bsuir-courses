require 'test_helper'

class UpdateControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get update_index_url
    assert_response :success
  end

end
