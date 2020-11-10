Rails.application.routes.draw do
  resources :cars
  resources :users
  devise_for :users, :path_prefix => 'my'

  devise_scope :user do
    authenticated :user do
      root to: 'users#index', as: :authenticated_root
    end

    unauthenticated :user do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
