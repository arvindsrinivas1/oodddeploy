class AddKeysToReviews < ActiveRecord::Migration[6.1]
  def change
    add_reference :reviews, :user, null: false, foreign_key: true
    add_reference :reviews, :book, null: false, foreign_key: true
  end
end
