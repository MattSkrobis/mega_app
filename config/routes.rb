Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  namespace :admin do
    resources :covers
    resources :users
    resources :comments
    resources :avatars
    resources :books
  end

  namespace :editor do
    resources :books
    resources :comments, only: [:edit, :update, :delete]
  end

  resources :books, only: [:index, :show] do
    resources :comments, except: [:index, :show]
  end
end
