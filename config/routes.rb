Rails.application.routes.draw do
  root 'landing_pages#show'
  get '/:locale', to: 'landing_pages#show', constraints: { locale: /jp/ }, as: 'landing'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/home', to: 'home_pages#show', as: 'home'
  resources :users, except: :new
  resources :account_activations, only: [:edit]
end
