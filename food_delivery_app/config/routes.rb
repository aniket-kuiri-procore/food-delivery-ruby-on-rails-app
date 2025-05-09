Rails.application.routes.draw do
  get "executives/new"
  get "executives/create"
  get "executives/show"
  get "executives/get_assigned_order"
  get "executives/pick_up"
  get "executives/deliver"
  get "restaurants/new"
  get "restaurants/create"
  get "restaurants/show"
  get "restaurants/add_food_item"
  get "restaurants/pending_orders"
  get "restaurants/confirm_order"
  get "restaurants/reject_order"
  get "orders/create"
  get "orders/show"
  #get "customers/new"
  #get "customers/create"
  get '/customers/new', to: 'customers#new'
  get '/customers', to: 'customers#index'
  post '/customers', to: 'customers#create'
  get '/customers/:id', to: 'customers#show', as: 'customer'

  get '/customers/:customer_id/restaurants', to: 'customers#get_restaurants', as: 'customer_restaurants' # this should have a separate call in CustomerController
  
  get '/customers/:customer_id/restaurants/:restaurant_id', to: 'customers#get_restaurant_menu', as: 'customer_restaurant_menu' # this should have a separate call in CustomerController

  post '/customers/:customer_id/orders', to: 'orders#create'
  get '/customers/:customer_id/orders/:order_id', to: 'customers#show_order', as: 'customer_order' #get customer order details

  # Restaurants Endpoints
  get '/restaurants/new', to: 'restaurants#new', as: 'new_restaurant'
  post '/restaurants', to: 'restaurants#create', as: 'restaurants'
  get '/restaurants', to: 'restaurants#index'
  get '/restaurants/:restaurant_id', to: 'restaurants#show', as: 'restaurant'
  post '/restaurants/:restaurant_id/menu_items', to: 'restaurants#add_food_item', as: 'restaurant_menu_items'
  get '/restaurants/:restaurant_id/pending_orders', to: 'restaurants#pending_orders', as: 'restaurant_pending_orders'
  post '/restaurants/:restaurant_id/orders/:order_id/confirm', to: 'restaurants#confirm_order', as: 'confirm_restaurant_order'
  post '/restaurants/:restaurant_id/orders/:order_id/reject', to: 'restaurants#reject_order', as: 'reject_restaurant_order'


  get '/orders', to: 'orders#index'
  # get 'orders/assign', to: 'orders#' 

  get "/executives/new", to: 'executives#new'
  get '/executives', to: 'executives#index'
  post '/executives', to: 'executives#create' 
  get '/executives/:executive_id', to: 'executives#show', as: 'executive' 
  get '/executives/:executive_id/order', to: 'executives#view_order', as: 'executive_order' 
  post '/executives/:executive_id/orders/:order_id/pickup', to: 'executives#pick_up'
  post '/executives/:executive_id/orders/:order_id/deliver', to: 'executives#deliver'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
