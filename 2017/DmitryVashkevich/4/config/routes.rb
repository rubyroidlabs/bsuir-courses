Rails.application.routes.draw do
  resources :adverts do
    resources :responses, only: [:create]
  end
  get '/adverts/currency/:currency' => 'adverts#index'
  root 'adverts#index'
end
