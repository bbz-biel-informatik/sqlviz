Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'pages#index'
  resources :documentations, only: [:show]
  resources :pages do
    resources :visuals do
      post :sort, on: :collection
    end
    resources :memberships
  end

  resources :sensors
end
