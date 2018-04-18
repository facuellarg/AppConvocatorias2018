Rails.application.routes.draw do
  resources :convocations
  devise_for :admins
  post 'admin_token' => 'admin_token#create'
  resources :documents
  post 'user_token' => 'user_token#create'
  resources :users
  devise_for :users
  resources :dependences, only: [:index]
  post 'search_convocations' => 'convocations#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
