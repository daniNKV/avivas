Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "landing#index"
  post "/" => "landing#index", as: "landing"
  get "/show/:id" => "landing#show", as: :show_product

  namespace :admin do
    root to: "dashboard#index"
    get "profiles/edit"
    patch "profiles/update"
    get "profiles/:username", to: "profiles#show", as: "public_profile"
    get "users/search", to: "users#search"
    get "products/search", to: "products#search"
    resources :invoices, except: [ :edit, :update ] do
      member do
        patch :cancel
      end
    end
    resources :users do
      member do
        post :block
        post :activate
      end
    end
    namespace :products do
      resources :categories, except: :show
    end
    resources :products do
      member do
        get :update_stock
        patch :update_stock
        post :publish
        post :hide
        get :add_images
        delete :destroy_image
      end
    end
  end

  resources :passwords, controller: "clearance/passwords", only: [ :create, :new ]
  resource :session, controller: "clearance/sessions", only: [ :create ]

  resources :users, controller: "clearance/users", only: [ :create ] do
    resource :password,
      controller: "clearance/passwords",
      only: [ :edit, :update ]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  # get "/sign_up" => "clearance/users#new", as: "sign_up"

  # scope module: "storefront" do
  # end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
