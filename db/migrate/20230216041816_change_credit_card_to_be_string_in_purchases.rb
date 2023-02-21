class ChangeCreditCardToBeStringInPurchases < ActiveRecord::Migration[6.1]
  def up
    change_column :purchases, :credit_card, :string
    change_column :purchases, :phone_number, :string
  end

  def down
    change_column :purchases, :credit_card, :string
    change_column :purchases, :phone_number, :string
  end
end
