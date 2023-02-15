class AddKeysToCartDetails < ActiveRecord::Migration[6.1]
  def change
    add_reference :cart_details, :book, null: false, foreign_key: true
    add_reference :cart_details, :cart, null: false, foreign_key: true
  end
end
