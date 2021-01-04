Rails.application.routes.draw do
  resources :studios, only: [:index]
end
