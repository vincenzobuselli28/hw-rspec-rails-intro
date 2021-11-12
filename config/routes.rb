Rottenpotatoes::Application.routes.draw do
    
    get 'search_tmdb', to: 'movies#search_tmdb'
    get 'add_movie', to: 'movies#add_movie'
  
    resources :movies
    # map '/' to be a redirect to '/movies'
    root :to => redirect('/movies')
  end
  