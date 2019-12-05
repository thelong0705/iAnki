Rails.application.routes.draw do
  root 'landing_pages#index'
  get '/:locale', to: 'landing_pages#index', constraints: { locale: /jp/ }, as: 'landing'
  get 'search/', to: "search#index", as: "search"
  get 'password_resets/new'
  get 'password_resets/edit'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/home', to: 'home_pages#index', as: 'home'
  resources :users, except: :new
  resources :account_activations, only: [:edit, :index]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :decks do
    post :import, on: :collection
  end
  resources :study_sessions, only: [:show, :update]
  post '/cards/search', to: 'cards#search'
end
