Myflix::Application.routes.draw do
  root to: 'pages#front'

  resources :videos, only: [:index, :show] do
    collection do
      get :search, to: 'videos#search'
    end
  end
  resources :users, only: [:create]
  # resources :categories

   get 'ui(/:action)', controller: 'ui'
   get 'register', to: 'users#new'
   get 'sign_in', to: 'sessions#new'
end