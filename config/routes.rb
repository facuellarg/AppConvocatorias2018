Rails.application.routes.draw do
  resources :admins
  resources :convocations, only: [:create,:show]
  post 'admin_token' => 'admin_token#create'
  resources :documents
  post 'user_token' => 'user_token#create'
  resources :users
  post 'users/social'
  devise_for :users
  devise_for :admins
  resources :dependences, only: [:index]
  post 'search_convocations' => 'convocations#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
