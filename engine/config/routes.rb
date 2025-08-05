# frozen_string_literal: true

CitizensAdviceCookiePreferences::Engine.routes.draw do
  root to: "cookie_preferences#show"
  resource :cookie_preferences, path: "/cookie-preferences", only: %i[show edit update]
end
