require "test_helper"

class CartDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cart_detail = cart_details(:one)
  end

  test "should get index" do
    get cart_details_url
    assert_response :success
  end

  test "should get new" do
    get new_cart_detail_url
    assert_response :success
  end

  test "should create cart_detail" do
    assert_difference('CartDetail.count') do
      post cart_details_url, params: { cart_detail: { quantity: @cart_detail.quantity } }
    end

    assert_redirected_to cart_detail_url(CartDetail.last)
  end

  test "should show cart_detail" do
    get cart_detail_url(@cart_detail)
    assert_response :success
  end

  test "should get edit" do
    get edit_cart_detail_url(@cart_detail)
    assert_response :success
  end

  test "should update cart_detail" do
    patch cart_detail_url(@cart_detail), params: { cart_detail: { quantity: @cart_detail.quantity } }
    assert_redirected_to cart_detail_url(@cart_detail)
  end

  test "should destroy cart_detail" do
    assert_difference('CartDetail.count', -1) do
      delete cart_detail_url(@cart_detail)
    end

    assert_redirected_to cart_details_url
  end
end
