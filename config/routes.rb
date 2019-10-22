Rails.application.routes.draw do
  root "static_pages#home"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  
  resources :users 
  resources :categories
  resources :services
  resources :bills
  resources :feed_backs
  resources :rooms do
    resources :bills
  end
  get "/search_user", to: "users#index"
  post "/search_user", to: "users#search"
  get "/search_room", to: "rooms#index"
  post "/search_room", to: "rooms#search_room"
  get "/search_feed_back", to: "feed_backs#index"
  post "/search_feed_back", to: "feed_backs#search_feed_back"
end
