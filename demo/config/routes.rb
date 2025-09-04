# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index", as: :home
  get "(/:country)/show-page", to: "home#show"
  get "/helpers-page", to: "helpers_page#index"

  mount CitizensAdviceCookiePreferences::Engine, at: "(/:country)/cookie-preferences"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
