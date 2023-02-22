FactoryBot.define do
    factory :cart do
      id {1}
      user_id {1}

      trait :new_cart do
        id {2}
        user_id {2}
      end
    end
  end