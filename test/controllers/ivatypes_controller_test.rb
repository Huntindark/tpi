require 'test_helper'

class IvatypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ivatype = ivatypes(:one)
  end

  test "should get index" do
    get ivatypes_url, as: :json
    assert_response :success
  end

  test "should create ivatype" do
    assert_difference('Ivatype.count') do
      post ivatypes_url, params: { ivatype: { description: @ivatype.description } }, as: :json
    end

    assert_response 201
  end

  test "should show ivatype" do
    get ivatype_url(@ivatype), as: :json
    assert_response :success
  end

  test "should update ivatype" do
    patch ivatype_url(@ivatype), params: { ivatype: { description: @ivatype.description } }, as: :json
    assert_response 200
  end

  test "should destroy ivatype" do
    assert_difference('Ivatype.count', -1) do
      delete ivatype_url(@ivatype), as: :json
    end

    assert_response 204
  end
end
