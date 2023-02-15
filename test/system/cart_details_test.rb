require "application_system_test_case"

class CartDetailsTest < ApplicationSystemTestCase
  setup do
    @cart_detail = cart_details(:one)
  end

  test "visiting the index" do
    visit cart_details_url
    assert_selector "h1", text: "Cart Details"
  end

  test "creating a Cart detail" do
    visit cart_details_url
    click_on "New Cart Detail"

    fill_in "Quantity", with: @cart_detail.quantity
    click_on "Create Cart detail"

    assert_text "Cart detail was successfully created"
    click_on "Back"
  end

  test "updating a Cart detail" do
    visit cart_details_url
    click_on "Edit", match: :first

    fill_in "Quantity", with: @cart_detail.quantity
    click_on "Update Cart detail"

    assert_text "Cart detail was successfully updated"
    click_on "Back"
  end

  test "destroying a Cart detail" do
    visit cart_details_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cart detail was successfully destroyed"
  end
end
