Rails.application.routes.draw do
  # devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      # authentication
      post '/login', to: "sessions#create"
      post '/logout', to: "sessions#destroy"
      post '/signup', to: "users#create"
      get '/me', to: "users#me"

      resources :wallets, only: [:index, :create, :show, :update, :destroy] do
        resources :categories, only: [:index, :create, :show, :update]
        resources :transactions, only: [:index, :create, :show, :update, :destroy]
        resources :reports, only: [:index]
        resources :user_wallets, only: [:index, :create, :destroy], path: :members
      end

      resources :teams, only: [:create, :update, :destroy, :index]
    end  
  end
end
