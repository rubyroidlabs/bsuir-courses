Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  devise_scope :user do
    authenticated :user do
      root 'sayings#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  resources :sayings do
    resources :words
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
