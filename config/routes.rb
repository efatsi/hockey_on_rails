Rails.application.routes.draw do
  root to: "games#index"

  resources :games do
    resources :manual_events, only: :create
  end
end
