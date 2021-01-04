Rails.application.routes.draw do
  resources :studios, only: [:index]
  resources :movies, only: [:show, :update]
end
