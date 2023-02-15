Rails.application.routes.draw do
  devise_for :admins
  resources :cart_details
  resources :carts
  resources :purchases
  get "/cart/add_to_cart", to: "carts#add_to_cart"
  devise_for :users
  devise_for :views
  root to: "home#index"

  get 'home/index'
  resources :reviews
  resources :users, shallow: true
  resources :books, shallow: true
  resources :admin
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
