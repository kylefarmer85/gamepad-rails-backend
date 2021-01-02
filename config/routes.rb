Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do 
    namespace :v1 do
      resources :users
      resources :favorites
      resources :comments
      resources :games, only: [:show]
      resources :reviews, only: [:create, :destroy]

      post '/auth', to: 'auth#create'
      get '/current_user', to: 'auth#show'

      post '/games/search', to: 'games#search'
      post '/games/favorites', to: 'games#favorites'

      post '/games/consoleandgenre', to: 'games#console_and_genre'
      post '/games/yearandgenre', to: 'games#year_and_genre'
      post '/games/topbyconsole', to: 'games#top_by_console'
      post '/games/highestratedbyfollowings', to: 'games#highest_rated_by_followings'

      get '/reviews/:page', to: 'reviews#infinite_scroll'
      post '/reviews/gamereviews', to: 'reviews#game_reviews'

      post '/favorites/remove', to: 'favorites#remove'

      post '/users/following', to: 'users#following'
      post '/users/unfollow', to: 'users#unfollow'
      post '/users/searchbyconsoleandgenre', to: 'users#search_by_console_and_genre'
      post '/users/search', to: 'users#search'
    end 
  end
end

