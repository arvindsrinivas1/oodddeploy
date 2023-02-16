class ChangeCreditCardToBeStringInPurchases < ActiveRecord::Migration[6.1]
  def change
    change_column :purchases, :credit_card, :string
    change_column :purchases, :phone_number, :string
  end
end
