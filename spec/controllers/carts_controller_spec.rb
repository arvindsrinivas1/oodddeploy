require 'rails_helper'

RSpec.describe CartsController, type: :controller do
    login_user

    describe "Add to cart" do
        before(:each) do
            create(:book, :book1)
            create(:cart)
        end


        it 'creates a cart detail when a book is bought' do
            # call add to cart without existing cart detail

            initial_cart_detail_count = CartDetail.count
            post :add_to_cart, :params =>  {:book_id => Book.first.id }
            new_cart_detail_count = CartDetail.count
            expect(new_cart_detail_count).to eq(initial_cart_detail_count + 1)
        end

        it 'does not create a new cart detail for updating existing cart detail' do
            create(:cart_detail)
            initial_cart_detail_count = CartDetail.count
            post :add_to_cart, :params =>  {:book_id => Book.first.id, :quantity => 5}
            new_cart_detail_count = CartDetail.count

            expect(new_cart_detail_count).to eq(initial_cart_detail_count)
        end

        it 'modifies the quantity on update' do
            create(:cart_detail)
            post :add_to_cart, :params =>  {:book_id => Book.first.id, :quantity => 5}

            cart = Cart.where(user_id: 1).order("created_at").last
            cart_detail = CartDetail.where(cart_id: cart.id, book_id: Book.first.id).first

            expect(cart_detail.quantity).to eq(5)
        end

        it 'selects the latest cart for the user' do
            latest_cart = Cart.create(user_id: 1)
            post :add_to_cart, :params =>  {:book_id => Book.first.id }

            expect(CartDetail.last.cart_id).to eq(latest_cart.id)
        end

        it 'redirects to books url on success' do
            post :add_to_cart, :params =>  {:book_id => Book.first.id }
            expect(response).to redirect_to(books_url)
        end

        it 'sets the current notice message on creation' do
            post :add_to_cart, :params =>  {:book_id => Book.first.id }
            expect(flash[:notice]).to match(/Book was successfully added.*/)
        end

        it 'sets the current notice message on update' do
            create(:cart_detail)
            post :add_to_cart, :params =>  {:book_id => Book.first.id, :quantity => 5}
            expect(flash[:notice]).to match(/Quantity was successfully updated.*/)
        end
    end
end