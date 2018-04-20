Rails.application.routes.draw do
  root 'schedules#index'

  resources :schedules
  resources :students do
    collection do
      get 'search'
    end
  end
  resources :terms
  resources :bases
end
