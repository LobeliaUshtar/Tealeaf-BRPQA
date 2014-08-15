Myflix::Application.routes.draw do
  root to: 'videos#index'

  resources :videos, only: [:index, :show] do
    collection do
      get :search, to: 'videos#search'
    end
  end
  resources :users
  resources :categories

   get 'ui(/:action)', controller: 'ui' 
end