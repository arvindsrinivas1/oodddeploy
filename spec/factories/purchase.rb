FactoryBot.define do
    factory :purchase do
        cart_id {1}
        user_id {1}
        credit_card {'9999999999999999'}
        phone_number {'9999999911'}
    end
  end