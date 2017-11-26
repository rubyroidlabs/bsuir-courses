require 'test_helper'

class AdvertsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @advert = adverts(:one)
  end

  test 'should get index' do
    get adverts_url
    assert_response :success
  end

  test 'should get new' do
    get new_advert_url
    assert_response :success
  end

  test 'should create advert' do
    assert_difference('Advert.count') do
      post adverts_url, params: { advert: { description: @advert.description,
                                            name: @advert.name,
                                            phone: @advert.phone,
                                            tittle: @advert.tittle,
                                            type: @advert.type } }
    end

    assert_redirected_to advert_url(Advert.last)
  end

  test 'should show advert' do
    get advert_url(@advert)
    assert_response :success
  end

  test 'should get edit' do
    get edit_advert_url(@advert)
    assert_response :success
  end

  test 'should update advert' do
    patch advert_url(@advert), params: { advert:
                                           { description: @advert.description,
                                             name: @advert.name,
                                             phone: @advert.phone,
                                             tittle: @advert.tittle,
                                             type: @advert.type } }
    assert_redirected_to advert_url(@advert)
  end

  test 'should destroy advert' do
    assert_difference('Advert.count', -1) do
      delete advert_url(@advert)
    end

    assert_redirected_to adverts_url
  end
end
