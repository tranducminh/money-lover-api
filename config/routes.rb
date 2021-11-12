Rails.application.routes.draw do
  # devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      # authentication
      post '/login', to: "sessions#create"
      post '/logout', to: "sessions#destroy"
      post '/signup', to: "users#create"

      resources :wallets, only: [:index, :create, :show, :update, :destroy]
    end  
  end
end
