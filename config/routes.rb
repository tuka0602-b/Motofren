Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
   }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  resources :users, only: :show do
    member do
      get :following, :followers
      get :image_liked
      get :recruitment_liked
    end
  end
  resources :image_posts, only: [:show, :create, :destroy] do
    resources :comments, only: [:create, :destroy]
  end
  resources :recruitments
  resources :relationships, only: [:create, :destroy]
  resources :image_post_likes, only: [:create, :destroy]
  resources :recruitment_likes, only: [:create, :destroy]
  resources :talk_rooms, only: [:show]
end
