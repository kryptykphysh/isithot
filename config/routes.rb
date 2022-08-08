Rails.application.routes.draw do
  resources :temperature_definitions, only: [:create]

  post "weather_api/lookup"
  get "home/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
