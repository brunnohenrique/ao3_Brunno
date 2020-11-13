Rails.application.routes.draw do
  resources :vehicles
  resources :users
  resources :rents, only: [:new, :create]
  devise_for :users, :path_prefix => 'ao3'

  root to: 'home#index'
  
  devise_scope :user do
    authenticated :user do
      root to: 'vehicles#index', as: :authenticated_root
    end

    unauthenticated :user do
      root to: 'home#index', as: :unauthenticated_root
    end
  end
end
