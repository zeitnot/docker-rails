Rails.application.routes.draw do
  root 'polls#index'

  get 'healthz' => 'application#healthz'

  resources :polls, only: :index do
    post :vote, on: :member
  end
end
