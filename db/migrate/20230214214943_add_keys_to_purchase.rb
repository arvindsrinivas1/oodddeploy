class AddKeysToPurchase < ActiveRecord::Migration[6.1]
  def change
    add_reference :purchases, :user, null: false, foreign_key: true
    add_reference :purchases, :cart, null: false, foreign_key: true
  end
end
