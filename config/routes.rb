Rails.application.routes.draw do
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
  resources :terms
  resources :bases
end
