Rails.application.routes.draw do
  root 'landing_pages#home'
  get '/:locale', to: 'landing_pages#home', constraints: { locale: /jp/ }, as: 'home'
end
