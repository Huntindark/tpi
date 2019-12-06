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

  #USER
  post '/sesiones', to: 'users#login'
  post '/usuarios', to: 'users#create'
    
  #PRODUCTOS
  get '/productos', to: 'products#list_filtered'



  #TESTING
  get '/test', to: 'users#test'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
