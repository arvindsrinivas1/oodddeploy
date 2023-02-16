class Book < ApplicationRecord
    has_many :reviews, dependent: :delete_all
    has_many :cart_details, dependent: :delete_all
end
