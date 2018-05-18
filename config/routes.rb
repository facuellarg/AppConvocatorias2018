Rails.application.routes.draw do
  resources :admins
  resources :convocations, only: [:create,:show]
  get 'wanted_convocations' => 'convocations#most_wanted'
  get 'admin_convocations' => 'convocations#admin_convocations'
  get 'admin_convocation_details' => 'convocations#show_admin'
  get 'admin_files' => 'documents#admin_files'
  post 'admin_token' => 'admin_token#create'
  resources :documents
  post 'user_token' => 'user_token#create'
  resources :users
  post 'users/social'
  devise_for :users
  devise_for :admins
  resources :dependences, only: [:index]
  resources :applications, only: [:create,:index,:update]
  post 'search_convocations' => 'convocations#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
