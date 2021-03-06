Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  namespace :admin do
    resources :covers
    resources :users
    resources :comments
    resources :avatars
    resources :books
    resources :authors
    resources :publishers
  end

  namespace :editor do
    resources :books do
      resources :comments, only: [:edit, :update, :destroy]
    end
  end

  resources :books, only: [:index, :show] do
    resources :comments, except: [:index, :show]
  end
end
