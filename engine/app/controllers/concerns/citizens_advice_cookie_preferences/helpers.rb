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
      # TODO: Figure out logic for launching i.e. ensure we delete all analytics cookies if present before a user consents
      # Other decisions to make:
      # 1. Do we store a list/hash of both essential and non-essential cookies so that we don't ever end up in a situation where someone
      # adds a cookie without going through the process and makes us non-compliant as we'll write code to just throw any unknown cookies away
      # 2. Does the version number need to become a hash made up of all the cookies?
      
      return if cookies[:cookie_preference_set] == COOKIE_CURRENT_VERSION

      # return if cookies[:cookie_preference_set].blank? || cookies[:cookie_preference_set] == COOKIE_CURRENT_VERSION

      reset_cookie_consent
    end

    def reset_cookie_consent
      cookies[:cokie_preference] = {
        value: { essential: true, analytics: false, video_players: false }.to_json,
        expires: 1.year,
        domain: :all
      }

      # Delete cookie_preference_set so that banner is rendered and a user can re-consent
      cookies.delete :cookie_preference_set

      # Delete all analytics cookies
      ANAYLTICS_COOKIES.each do |cookie_abbreviation|
        cookies.each do |cookie|
          cookie_name = cookie[0]
          cookies.delete cookie_name if cookie_name.start_with?(cookie_abbreviation)
        end
      end
    end
  end
end
