Rails.application.routes.draw do
  get 'articles/index'
  resources :articles
  resources :convers
  resources :articles do
    resources :comments
  end
  root 'articles#index'
end
