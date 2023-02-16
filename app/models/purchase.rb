class Purchase < ApplicationRecord
    belongs_to :cart

    validates :credit_card, length: { is: 16 }
    validates :phone_number, length: { is: 10 }
end
