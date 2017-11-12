require 'test_helper'

class SayingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @saying = sayings(:one)
  end

  test "should get index" do
    get sayings_url
    assert_response :success
  end

  test "should get new" do
    get new_saying_url
    assert_response :success
  end

  test "should create saying" do
    assert_difference('Saying.count') do
      post sayings_url, params: { saying: { text: @saying.text } }
    end

    assert_redirected_to saying_url(Saying.last)
  end

  test "should show saying" do
    get saying_url(@saying)
    assert_response :success
  end

  test "should get edit" do
    get edit_saying_url(@saying)
    assert_response :success
  end

  test "should update saying" do
    patch saying_url(@saying), params: { saying: { text: @saying.text } }
    assert_redirected_to saying_url(@saying)
  end

  test "should destroy saying" do
    assert_difference('Saying.count', -1) do
      delete saying_url(@saying)
    end

    assert_redirected_to sayings_url
  end
end
