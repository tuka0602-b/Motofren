Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
   }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  resources :users, only: [:show] do
    member do
      get :following, :followers
    end
  end
  resources :image_posts, only: [:show, :create, :destroy]
end
