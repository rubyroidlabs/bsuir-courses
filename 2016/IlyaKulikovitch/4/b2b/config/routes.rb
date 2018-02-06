Rails.application.routes.draw do
  root 'posts#index'
  resources :posts do
  	resources :comments
  end
  get 'posts_one', to: 'posts#index_sale'
  get 'posts_second', to: 'posts#index_purchase'
end
