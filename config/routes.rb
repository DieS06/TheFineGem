Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  devise_for :users, controllers: {
  sessions: "users/sessions",
  registrations: "users/registrations",
  passwords: "users/passwords",
  confirmations: "users/confirmations",
  unlocks: "users/unlocks"
  }
  resources :users, only: [ :index, :show ]

  authenticated :user do
    root to: "hotels#index", as: :authenticated_root
  end

  unauthenticated do
    devise_scope :user do
      root to: "users/sessions#new", as: :unauthenticated_root
    end
  end

  resources :hotels do
    resources :addresses
  end
  resources :rooms
  resources :comments
  resources :reserve_rooms do
    resources :payments
  end
end
