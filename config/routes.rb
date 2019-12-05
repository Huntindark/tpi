Rails.application.routes.draw do
  resources :solds
  resources :sells
  resources :reserveds
  resources :reservations
  resources :clients
  resources :ivatypes
  resources :users
  resources :phones
  resources :items
  resources :products

  post '/sesiones', to: 'users#login'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
