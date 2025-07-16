module CitizensAdviceCookiePreferences
  module CookiePreferencesHelpers
    extend ActiveSupport::Concern

    included do
      before_action :set_cookie_preferences
    end

    protected

    def set_cookie_preferences
      if cookies[:cookie_preference].present?
        CurrentCookies.preference = JSON.parse(cookies[:cookie_preference])
      end
    end
  end
end