# frozen_string_literal: true

CitizensAdviceCookiePreferences::Engine.routes.draw do
  root to: "/"
  resource :cookie_preference, only: %i[show edit update]
end
