Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
}

  authenticated :user, ->(user) { user.admin? } do
    mount Avo::Engine, at: Avo.configuration.root_path
  end

  get "/avo", to: redirect("/users/sign_in")
  get "/avo/*path", to: redirect("/users/sign_in")

  mount LetterOpenerWeb::Engine, at: "/letters" if Rails.env.development?

  root "searches#index"

  resources :searches, only: [ :index, :show, :create, :update, :destroy ] do
    resources :search_permissions, only: [ :destroy ]

    resources :search_invitations, only: [ :create ]

    resources :properties, only: [ :show, :create, :update, :destroy ] do
      member do
        patch :toggle_status
      end

      resources :property_events, only: [ :create ]
    end
  end

  resources :search_invitations, only: [ :show ] do
    member do
      patch :accept
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
