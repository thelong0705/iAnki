Rails.application.routes.draw do
  root 'landing_pages#home'
  get '/:locale', to: 'landing_pages#home', constraints: { locale: /jp/ }, as: 'home'
  get '/sign_up', to: 'users#new'
  resources :users
end
