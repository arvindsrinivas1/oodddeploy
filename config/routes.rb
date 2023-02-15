Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  devise_for :views
  root to: "home#index"

  get 'home/index'
  resources :reviews
  resources :users, shallow: true
  resources :transactions
  resources :books, shallow: true
  resources :admin
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
