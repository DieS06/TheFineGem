Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  mount Fakesite::Engine => "/fakesite" if Rails.env.development?

  devise_for :users, controllers: {
  sessions: "users/sessions",
  registrations: "users/registrations",
  passwords: "users/passwords",
  confirmations: "users/confirmations",
  unlocks: "users/unlocks"
  }

  root to: "hotels#index"

  resources :users, only: [ :index, :show, :destroy, :edit, :update ]
  resources :hotels, only: [ :index, :show, :new, :create, :edit, :update, :destroy ] do
    resources :addresses, only: [ :index, :show, :new, :create, :edit, :update, :destroy ]
  end

  resources :rooms, only: [ :index, :show, :new, :create, :edit, :update, :destroy ]  do
    resources :comments
  end

    resources :reserve_rooms, only: [ :index, :show, :new, :create, :edit, :destroy ]  do
      resources :payments, only: [ :index, :show, :new, :create, :edit ]
  end
end
