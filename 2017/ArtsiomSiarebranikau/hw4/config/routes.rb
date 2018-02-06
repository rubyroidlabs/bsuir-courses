Rails.application.routes.draw do
  get 'artciles/index'

  resources :articles

  root 'articles#index'
end
