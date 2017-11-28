Rails.application.routes.draw do
  get 'welcom/index'
  resources :articles
  root 'welcom#index'

end
