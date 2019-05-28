Rails.application.routes.draw do
  root 'polls#index'

  resources :polls, only: :index do
    post :vote, on: :member
  end
end
