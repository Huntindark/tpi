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
  resources :products, path: 'productos' do
    collection do 
      get :show_prod_items, path: ':id/items'
      post :create_prod_items, path: ':id/items'
    end
  end
  resources :reservations, path: 'reservas' do
    collection do
      put :sell, path: ':id/vender'
    end
  end   
  resources :sells, path: 'ventas'  do
    collection do
      get :user_sales, path: ''
      get :user_sale, path: ':id'
      post :sell, path: ''
    end
  end 

  #AUTHENTICATION
  get '/authenticate', to: 'tokens#authenticate'



=begin 
  #SELL
  get '/ventas', to: 'sells#user_sales'
  get '/ventas/:id', to: 'sells#user_sale'
  post '/ventas', to: 'sells#sell'
  #CLIENT
  post '/clientes', to: 'clients#register'
 resources :users do
    member do 
      post 
    end
  end
=end
=begin
  #RESERVATION
  get '/reservas', to: 'reservations#not_sold'
  get '/reservas/:id', to: 'reservations#by_id'
  post '/reservas', to: 'reservations#reserve'
  put '/reservas/:id/vender', to: 'reservations#sell'
  delete 'reservas/:id', to: 'reservations#cancel'
=end
  #USER
  post '/sesiones', to: 'users#session'
  post '/usuarios', to: 'users#create'
    
  #PRODUCT
=begin
  get '/productos', to: 'products#list_filtered'
  get '/productos/:code', to: 'products#show_prod'
  get '/productos/:code/items', to: 'products#show_prod_items'
  post '/productos/:code/items', to: 'products#create_prod_items'
=end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end