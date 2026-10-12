Rails.application.routes.draw do
  root to: "books#search"

  get "books/search", to: "books#search"
  post "books", to:  "books#create"
  get "up" => "rails/health#show", as: :rails_health_check
  resources :users, only: %i[new create]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end
