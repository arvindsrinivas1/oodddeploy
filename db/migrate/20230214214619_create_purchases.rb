class CreatePurchases < ActiveRecord::Migration[6.1]
  def change
    create_table :purchases do |t|
      t.numeric :credit_card
      t.numeric :phone_number
      t.text :address
      t.decimal :total_price

      t.timestamps
    end
  end
end
