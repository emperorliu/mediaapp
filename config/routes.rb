Rails.application.routes.draw do
  root to: 'sessions#new'
  resources :sessions, only: [:create]
  get '/logout', to: 'sessions#destroy'

  get '/register', to: 'users#new'
  resources :users, only: [:create]

  resources :media_items do |variable|
    collection do
      get :search, to: 'media_items#search'
    end
  end
end
