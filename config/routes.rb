Rails.application.routes.draw do
  resources :documents
  post 'user_token' => 'user_token#create'
  post '/users' => 'register#create'
  devise_for :users
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
