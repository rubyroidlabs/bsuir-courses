Rails.application.routes.draw do
  get 'about/index'
  get 'update/index'
  root 'articles#index'
  resources :articles do
    resources :comments
  end
end
