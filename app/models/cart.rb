class Cart < ApplicationRecord
    has_many :cart_details, dependent: :destroy
    has_many :purchases, dependent: :destroy
    belongs_to :user
end
