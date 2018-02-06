Rails.application.routes.draw do
  resources :b2_bs
  resources :sell_posts, except: [:edit, :update]
  root to: 'sell_posts#index'
end
