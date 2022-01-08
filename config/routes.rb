Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :warehouses, only: [:show, :new, :create, :edit, :update] do
    get 'search', on: :collection
  end
  resources :suppliers, only: [:show, :new, :create, :index]
  resources :product_models, only: [:show, :new, :create, :edit, :update, :index]
  resources :product_bundles, only: [:show, :new, :create]
  resources :categories, only: [:show, :new, :create, :index]
  get 'product_items', to: 'product_items#new'
  post 'product_items', to: 'product_items#create'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do # versionamento de API
      resources :warehouses, only: [:index, :show]
      resources :suppliers, only: [:index, :show] 
      resources :product_models, only: [:index, :show]
    end
  end

end
