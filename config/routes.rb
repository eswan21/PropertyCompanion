Rails.application.routes.draw do
  devise_for :users
  root "searches#index"
 
  resources :searches, only: [ :index, :show, :create, :update, :destroy ] do
    resources :properties, only: [:show, :create, :update, :destroy ]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
