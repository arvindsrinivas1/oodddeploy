class Book < ApplicationRecord
    has_many :reviews, dependent: :destroy
    has_many :cart_details, dependent: :destroy

    validate :price_numeric_check

    def price_numeric_check
        if self.price.nil? or self.price <= 0
            errors.add(:price, 'must be a positive number')
        end
    end
end
