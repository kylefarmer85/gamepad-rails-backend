Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do 
    namespace :v1 do
      # resources :games
      resources :users
      resources :reviews
      resources :favorites
      post '/games/search', to: 'games#search'
      get '/games/:id', to: 'games#show'
      post '/games/favorites', to: 'games#favorites'
      post '/auth', to: 'auth#create'
      get '/current_user', to: 'auth#show'
    end 
  end
end

