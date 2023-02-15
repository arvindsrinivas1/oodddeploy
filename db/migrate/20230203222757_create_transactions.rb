class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.string :transaction_number, limit: 10
      t.string :credit_card_number, limit: 16
      t.string :address
      t.string :phone_no, limit: 10
      t.integer :quantity
      t.decimal :total_price

      t.timestamps
    end
  end
end
