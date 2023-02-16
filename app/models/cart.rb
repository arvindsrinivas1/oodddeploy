class Cart < ApplicationRecord
    has_many :cart_details, dependent: :delete_all
    belongs_to :user
end
