Rails.application.routes.draw do
  get "books/search", to: "books#search"
  post "books", to:  "books#create"
  get "up" => "rails/health#show", as: :rails_health_check
end
