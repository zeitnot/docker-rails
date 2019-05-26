Rails.application.routes.draw do
  root 'polls#index'

  resources :polls, only: :index
end
