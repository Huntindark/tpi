require 'test_helper'

class SellsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sell = sells(:one)
  end

  test "should get index" do
    get sells_url, as: :json
    assert_response :success
  end

  test "should create sell" do
    assert_difference('Sell.count') do
      post sells_url, params: { sell: { client_id: @sell.client_id, reservation_id: @sell.reservation_id, user_id: @sell.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show sell" do
    get sell_url(@sell), as: :json
    assert_response :success
  end

  test "should update sell" do
    patch sell_url(@sell), params: { sell: { client_id: @sell.client_id, reservation_id: @sell.reservation_id, user_id: @sell.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy sell" do
    assert_difference('Sell.count', -1) do
      delete sell_url(@sell), as: :json
    end

    assert_response 204
  end
end
