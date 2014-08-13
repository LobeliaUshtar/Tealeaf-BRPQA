Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root to: 'videos#index'

  resources :videos, only: [:index, :show] do
    collection do
      get 'search', to: 'videos#search'
    end

    member do
      post 'highlight', to: 'videos#highlight'
    end
  end
  resources :users, only: [:index, :show]
  resources :categories, only: [:index, :show]
end