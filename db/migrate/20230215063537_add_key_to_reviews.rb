class AddKeyToReviews < ActiveRecord::Migration[6.1]
  def change
    add_reference :reviews, :admin, foreign_key: true
    change_column_null :reviews, :user_id, null: true
  end
end
