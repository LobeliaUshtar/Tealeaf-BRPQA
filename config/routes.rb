Myflix::Application.routes.draw do
  root to: 'pages#front'

  get 'home', to: 'videos#index'

  resources :videos, only: [:index, :show] do
    collection do
      get :search, to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end
  resources :categories

  resources :users, only: [:create, :show]
  get 'register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  get 'sign_out', to: 'sessions#destroy'

  resources :queue_items, only: [:create, :destroy]
  get 'queue', to: 'queue_items#index'
  post 'update_queue', to: 'queue_items#update'

  resources :relationships, only: [:create, :destroy]
  get 'people', to: 'relationships#index'

  get 'forgot_password', to: 'forgot_passwords#new'
  resources :forgot_passwords, only: [:create]
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'

  resources :password_resets, only: [:show, :create]
  get 'expired_token', to: 'password_resets#expired_token'
  
  get 'ui(/:action)', controller: 'ui'
end