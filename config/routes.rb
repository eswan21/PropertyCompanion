Rails.application.routes.draw do
  devise_for :users
  root "searches#index"

  resources :searches, only: [ :index, :show, :create, :update, :destroy ] do
    resources :properties, only: [ :show, :create, :update, :destroy ] do
      member do
        patch :toggle_status
      end

      resources :property_events, only: [ :create ]
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
