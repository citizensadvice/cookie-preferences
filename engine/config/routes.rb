# frozen_string_literal: true

CitizensAdviceCookiePreferences::Engine.routes.draw do
  # root to: "cookie_preferences_page#index"
  # root to: "cookie_preferences#edit"
  root to: "/"
  resource :cookie_preference, only: %i[show edit update]
end
