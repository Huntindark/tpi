require 'test_helper'

class SoldsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sold = solds(:one)
  end

  test "should get index" do
    get solds_url, as: :json
    assert_response :success
  end

  test "should create sold" do
    assert_difference('Sold.count') do
      post solds_url, params: { sold: { item_id: @sold.item_id, price: @sold.price, sell_id: @sold.sell_id } }, as: :json
    end

    assert_response 201
  end

  test "should show sold" do
    get sold_url(@sold), as: :json
    assert_response :success
  end

  test "should update sold" do
    patch sold_url(@sold), params: { sold: { item_id: @sold.item_id, price: @sold.price, sell_id: @sold.sell_id } }, as: :json
    assert_response 200
  end

  test "should destroy sold" do
    assert_difference('Sold.count', -1) do
      delete sold_url(@sold), as: :json
    end

    assert_response 204
  end
end
