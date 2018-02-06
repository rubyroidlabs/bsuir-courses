Rails.application.routes.draw do
  # add rest resource
  resources :articles do
    resources :comments
  end
  # get
  # get 'articles/index'
  # for root page
  root 'articles#index'
end
