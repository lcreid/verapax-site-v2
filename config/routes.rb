# frozen_string_literal: true

Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"
  get "contact-us", to: "home#contact_us"
  get "life-long-learning", to: "home#life_long_learning"
  get "our-approach", to: "home#our_approach"
  get "our-team", to: "home#our_team"
  get "privacy-policy", to: "home#privacy_policy"
  get "services", to: "home#services"
  get "thank-you", as: "contact_thank_you", to: "home#thank_you"
  get "verapax-means", to: "home#verapax_means"
  get "who-we-work-with", to: "home#who_we_work_with"

  resources :contacts, only: [ :create, :new, :show ]

  get "dashboard", to: "dashboard#show"

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
