require 'test_helper'

class AdvertisementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @advertisement = advertisements(:one)
  end

  test "should get index" do
    get advertisements_url
    assert_response :success
  end

  test "should get new" do
    get new_advertisement_url
    assert_response :success
  end

  test "should create advertisement" do
    assert_difference('Advertisement.count') do
      post advertisements_url, params: { advertisement: { contacts: @advertisement.contacts, deal: @advertisement.deal, description: @advertisement.description, title: @advertisement.title } }
    end

    assert_redirected_to advertisement_url(Advertisement.last)
  end

  test "should show advertisement" do
    get advertisement_url(@advertisement)
    assert_response :success
  end

  test "should get edit" do
    get edit_advertisement_url(@advertisement)
    assert_response :success
  end

  test "should update advertisement" do
    patch advertisement_url(@advertisement), params: { advertisement: { contacts: @advertisement.contacts, deal: @advertisement.deal, description: @advertisement.description, title: @advertisement.title } }
    assert_redirected_to advertisement_url(@advertisement)
  end

  test "should destroy advertisement" do
    assert_difference('Advertisement.count', -1) do
      delete advertisement_url(@advertisement)
    end

    assert_redirected_to advertisements_url
  end
end
