FactoryBot.define do
    factory :book do
        trait :book1 do
            id {1}
            name {'Book1'}
            author {'Author1'}
            publisher {'Publisher1'}
            price {100}
            stock {200}
        end
        trait :book2 do
            id {2}
            name {'Book2'}
            author {'Author2'}
            publisher {'Publisher2'}
            price {200}
            stock {50}
        end
        trait :book3 do
            id {3}
            name {'Book3'}
            author {'Author3'}
            publisher {'Publisher3'}
            price {50}
            stock {200}
        end
        trait :book4 do
            id {4}
            name {'Book4'}
            author {'Author4'}
            publisher {'Publisher4'}
            price {150}
            stock {250}
        end
    end
end
  