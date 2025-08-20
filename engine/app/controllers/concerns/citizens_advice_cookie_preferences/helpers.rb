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
      before_action :set_cookie_preferences, :check_cookie_version
      helper_method :cookies_preference_page?, :allow_analytics_cookies?, :allow_video_players_cookies?

      def cookies_preference_page?
        false
      end

      def allow_analytics_cookies?
        CitizensAdviceCookiePreferences::CurrentCookies.analytics?
      end

      def allow_video_players_cookies?
        CitizensAdviceCookiePreferences::CurrentCookies.video_players?
      end
    end

    protected

    def set_cookie_preferences
      return if cookies[:cookie_preference].blank?

      CurrentCookies.preference = JSON.parse(cookies[:cookie_preference])
    end

    def check_cookie_version
      return if cookies[:cookie_preference_set] == COOKIE_CURRENT_VERSION

      reset_cookie_consent
    end

    def reset_cookie_consent
      cookies[:cookie_preference] = {
        value: { essential: true, analytics: false, video_players: false }.to_json,
        expires: 1.year,
        domain: :all
      }

      # Delete cookie_preference_set so that banner is rendered and a user can re-consent
      cookies.delete :cookie_preference_set

      CookieManagement.new(cookies).delete_unconsented_cookies!
    end
  end
end
