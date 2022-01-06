Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :warehouses, only: [:show, :new, :create, :edit, :update]
  resources :suppliers, only: [:show, :new, :create, :index]
  resources :product_models, only: [:show, :new, :create, :edit, :update, :index]
  resources :product_bundles, only: [:show, :new, :create]
  resources :categories, only: [:show, :new, :create, :index]
  get 'product_items', to: 'product_items#new'
  post 'product_items', to: 'product_items#create'
  get 'search', to:"home#search"

  
end
