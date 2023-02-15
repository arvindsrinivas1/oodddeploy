class AddKeysToAdmins < ActiveRecord::Migration[6.1]
  def change
    add_column :admins, :username, :string
    add_column :admins, :name, :string
  end
end
