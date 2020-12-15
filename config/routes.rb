Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do 
    namespace :v1 do
      # resources :games
      resources :users
      resources :favorites
      resources :games, only: [:show]
      resources :reviews, only: [:destroy, :create]
      post '/auth', to: 'auth#create'
      get '/current_user', to: 'auth#show'
      post '/games/search', to: 'games#search'
      post '/games/favorites', to: 'games#favorites' #change to favorites controller?
      post '/reviews/all', to: 'reviews#reviews_all'


    end 
  end
end

