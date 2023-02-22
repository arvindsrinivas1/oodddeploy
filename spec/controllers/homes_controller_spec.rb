require 'rails_helper'

RSpec.describe HomeController, type: :controller do
    login_user

    describe "Create cart" do
        it 'creates cart if cart does not exist for user' do
            user_cart_count = Cart.where(user_id: 1).count
            get :index
            new_user_cart_count = Cart.where(user_id: 1).count

            expect(new_user_cart_count).to eq(user_cart_count + 1)
        end

        it 'creates cart if cart exists but has been checked out already' do
            create(:cart)
            create(:purchase)
            user_cart_count = Cart.where(user_id: 1).count
            get :index
            new_user_cart_count = Cart.where(user_id: 1).count

            expect(new_user_cart_count).to eq(user_cart_count + 1)
        end
    end
end