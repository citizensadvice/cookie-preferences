# frozen_string_literal: true

# Utility for including shared view and controller helpers
# class ApplicationController < ActionController::Base
#   include CitizensAdviceCookiePreferences::Helpers
#   [...]
# end
module CitizensAdviceCookiePreferences
  module Helpers
    extend ActiveSupport::Concern

    included do
      before_action :set_cookie_preferences
      helper_method :cookies_preference_page?

      def cookies_preference_page?
        false
      end
    end

    protected

    def set_cookie_preferences
      return if cookies[:cookie_preference].blank?

      CurrentCookies.preference = JSON.parse(cookies[:cookie_preference])
    end
  end
end
