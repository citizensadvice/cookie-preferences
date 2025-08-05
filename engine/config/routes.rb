# frozen_string_literal: true

CitizensAdviceCookiePreferences::Engine.routes.draw do
  resource :cookie_preference, path: "/", only: %i[show edit update]
end
