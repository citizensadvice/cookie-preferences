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
      helper_method :cookies_preference_page?, :allow_analytics_cookies?, :allow_video_players_cookies?, :how_we_use_cookies_url

      def cookies_preference_page?
        false
      end

      def allow_analytics_cookies?
        CitizensAdviceCookiePreferences::CurrentCookies.analytics?
      end

      def allow_video_players_cookies?
        CitizensAdviceCookiePreferences::CurrentCookies.video_players?
      end

      def how_we_use_cookies_url(country)
        if country == "scotland"
          "/scotland/about-us/information/privacy-and-cookies-scotland/"
        elsif country == "wales"
          "/wales/about-us/information/how-we-use-cookies/"
        else
          "/about-us/information/how-we-use-cookies/"
        end
      end
    end

    protected

    def set_cookie_preferences
      return unless Feature.enabled?("FF_NEW_COOKIE_MANAGEMENT")
      return if cookies[:cookie_preference].blank?

      CurrentCookies.preference = JSON.parse(cookies[:cookie_preference])
    end

    def check_cookie_version
      return unless Feature.enabled?("FF_NEW_COOKIE_MANAGEMENT")
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
      cookies.delete(:cookie_preference_set, domain: :all)

      CookieManagement.new(cookies).delete_unconsented_cookies!
    end
  end
end
