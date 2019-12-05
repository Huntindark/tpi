require 'test_helper'

class ReservedsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reserved = reserveds(:one)
  end

  test "should get index" do
    get reserveds_url, as: :json
    assert_response :success
  end

  test "should create reserved" do
    assert_difference('Reserved.count') do
      post reserveds_url, params: { reserved: { item_id: @reserved.item_id, price: @reserved.price, reservation_id: @reserved.reservation_id } }, as: :json
    end

    assert_response 201
  end

  test "should show reserved" do
    get reserved_url(@reserved), as: :json
    assert_response :success
  end

  test "should update reserved" do
    patch reserved_url(@reserved), params: { reserved: { item_id: @reserved.item_id, price: @reserved.price, reservation_id: @reserved.reservation_id } }, as: :json
    assert_response 200
  end

  test "should destroy reserved" do
    assert_difference('Reserved.count', -1) do
      delete reserved_url(@reserved), as: :json
    end

    assert_response 204
  end
end
