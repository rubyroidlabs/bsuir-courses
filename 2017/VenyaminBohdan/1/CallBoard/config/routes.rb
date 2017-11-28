Rails.application.routes.draw do
  devise_for :users
#  devise_for :installs
  resources :ads do
    resources :comments
  end
  root 'ads#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
