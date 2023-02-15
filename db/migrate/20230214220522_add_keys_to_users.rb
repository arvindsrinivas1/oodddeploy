class AddKeysToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :username, :string
    add_column :users, :name, :string
    add_column :users, :credit_card, :string, limit: 16
    add_column :users, :phone_number, :string, limit: 10
  end
end
