Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  root 'landing_pages#index'
  get '/:locale', to: 'landing_pages#index', constraints: { locale: /jp/ }, as: 'landing'
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
