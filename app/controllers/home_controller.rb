class HomeController < ApplicationController
  before_action :create_cart
  
  def index
  end

  private
    def create_cart
      if(!current_user.nil?)
        carts = Cart.where(user_id: current_user.id)
        purchases = Purchase.where(cart_id: carts)
        if(carts.empty? == true || carts.size == purchases.size)
          Cart.create(user_id: current_user.id)
        end
      end
    end
end
