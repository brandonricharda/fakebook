Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :posts
  resources :friend_requests
  resources :users
  resources :likes
  resources :comments
  root "posts#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end