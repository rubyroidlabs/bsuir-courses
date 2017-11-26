Rails.application.routes.draw do
  root 'posters#index'

  resources :posters do
    resources :comments
  end
end
