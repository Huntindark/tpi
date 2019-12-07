Rails.application.routes.draw do
  resources :tokens
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

  #USER
  post '/sesiones', to: 'users#session'
  post '/usuarios', to: 'users#create'
    
  #PRODUCT
  get '/productos', to: 'products#list_filtered'
  get '/productos/:code', to: 'products#show_prod'
  get '/productos/:code/items', to: 'products#show_prod_items'
  post '/productos/:code/items', to: 'products#create_prod_items'

  #RESERVATION
  get '/reservas', to: 'reservations#not_sold'
  get '/reservas/:id', to: 'reservations#by_id'


  #TESTING


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
