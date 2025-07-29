# frozen_string_literal: true

module CitizensAdviceCookiePreferences
  module SetCookiePreferences
    extend ActiveSupport::Concern

    included do
      before_action :set_cookie_preferences
    end

    protected

    def set_cookie_preferences
      return if cookies[:cookie_preference].blank?

      CurrentCookies.preference = JSON.parse(cookies[:cookie_preference])
    end
  end
end
