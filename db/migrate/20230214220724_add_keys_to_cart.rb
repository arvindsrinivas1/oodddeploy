class AddKeysToCart < ActiveRecord::Migration[6.1]
  def change
    add_reference :carts, :user, null: false, foreign_key: true
  end
end
