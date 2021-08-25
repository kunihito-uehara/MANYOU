Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :edit, :update]
  
  namespace :admin do
    resources :users
  end
end