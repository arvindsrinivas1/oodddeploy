require "application_system_test_case"

class PurchasesTest < ApplicationSystemTestCase
  setup do
    @purchase = purchases(:one)
  end

  test "visiting the index" do
    visit purchases_url
    assert_selector "h1", text: "Purchases"
  end

  test "creating a Purchase" do
    visit purchases_url
    click_on "New Purchase"

    fill_in "Address", with: @purchase.address
    fill_in "Credit card", with: @purchase.credit_card
    fill_in "Phone number", with: @purchase.phone_number
    fill_in "Total price", with: @purchase.total_price
    click_on "Create Purchase"

    assert_text "Purchase was successfully created"
    click_on "Back"
  end

  test "updating a Purchase" do
    visit purchases_url
    click_on "Edit", match: :first

    fill_in "Address", with: @purchase.address
    fill_in "Credit card", with: @purchase.credit_card
    fill_in "Phone number", with: @purchase.phone_number
    fill_in "Total price", with: @purchase.total_price
    click_on "Update Purchase"

    assert_text "Purchase was successfully updated"
    click_on "Back"
  end

  test "destroying a Purchase" do
    visit purchases_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Purchase was successfully destroyed"
  end
end
