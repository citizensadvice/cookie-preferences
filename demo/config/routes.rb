# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index", as: :home
  get "/show-page", to: "home#show"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
