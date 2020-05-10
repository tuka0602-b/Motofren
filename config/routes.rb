Rails.application.routes.draw do
  root to: 'home#top'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [:index, :show]
end
