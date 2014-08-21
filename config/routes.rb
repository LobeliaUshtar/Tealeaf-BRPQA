Myflix::Application.routes.draw do
  root to: 'pages#front'

  get 'home', to: 'videos#index'

  resources :videos, only: [:index, :show] do
    collection do
      get :search, to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end
  resources :users, only: [:create]
  resources :categories
  
  get 'register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  get 'sign_out', to: 'sessions#destroy'
  get 'queue', to: 'queue_items#index'

  get 'ui(/:action)', controller: 'ui'
end