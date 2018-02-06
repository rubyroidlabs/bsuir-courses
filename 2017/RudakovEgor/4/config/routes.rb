Rails.application.routes.draw do
  resources :advertisements do
    resources :comments
  end

  get '', to: 'advertisements#index'
  get '/sell', to: 'advertisements#sell'
  get '/buy', to: 'advertisements#buy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
