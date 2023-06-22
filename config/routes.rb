Rails.application.routes.draw do
  root "users#index"
  
  devise_for :users

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :create, :new, :destroy] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:create]
    end
  end
end
