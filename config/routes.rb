Rails.application.routes.draw do
  devise_for :users

  authenticated :user, ->(user) { user.admin? } do
    mount Avo::Engine, at: Avo.configuration.root_path
  end

  get "/avo", to: redirect("/users/sign_in")
  get "/avo/*path", to: redirect("/users/sign_in")

  root "searches#index"

  resources :searches, only: [ :index, :show, :create, :update, :destroy ] do
    resources :search_permissions, only: [ :create, :destroy ]

    resources :properties, only: [ :show, :create, :update, :destroy ] do
      member do
        patch :toggle_status
      end

      resources :property_events, only: [ :create ]
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
