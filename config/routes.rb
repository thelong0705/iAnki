Rails.application.routes.draw do
  root 'landing_pages#home'
  get '/:locale', to: 'landing_pages#home', constraints: { locale: /jp/ }, as: 'home'
  resources :users, except: :new
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
