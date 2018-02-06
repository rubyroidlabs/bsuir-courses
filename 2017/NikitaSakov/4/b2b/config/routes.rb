Rails.application.routes.draw do
  resources :publications do
  	resources :comments
  end
end
