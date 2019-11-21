Rails.application.routes.draw do
  root 'landing_pages#show'
  get '/:locale', to: 'landing_pages#show', constraints: { locale: /jp/ }, as: 'landing'
  resources :users, except: :new
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/home', to: 'home_pages#show', as: 'home'

end
