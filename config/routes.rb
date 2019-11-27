Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  root 'landing_pages#show'
  get '/:locale', to: 'landing_pages#show', constraints: { locale: /jp/ }, as: 'landing'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/home', to: 'home_pages#show', as: 'home'
  resources :users, except: :new
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :decks
  resources :study_sessions, only: [:show, :update]
end
