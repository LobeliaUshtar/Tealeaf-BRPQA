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
  
  get 'ui(/:action)', controller: 'ui'
end