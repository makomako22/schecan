Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root 'schedules#index'

  resources :schedules do
    collection do
      get 'use'
    end
  end
  resources :students do
    collection do
      get 'search'
    end
  end
  resources :terms, only: [:index, :show, :new]
  resources :bases
  resources :users, only: [:edit ,:update]
  resources :briefings
end
