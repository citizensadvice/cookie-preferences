CitizensAdviceCookiePreferences::Engine.routes.draw do
  # root to: "cookie_preferences_page#index"
  # root to: "cookie_preference#edit"
  root to: "/"
  resource :cookie_preference, only: %i[show edit update]
end
