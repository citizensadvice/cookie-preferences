# frozen_string_literal: true

# Utility for including shared view and controller helpers
# class ApplicationController < ActionController::Base
#   include CitizensAdviceCookiePreferences::Helpers
#   [...]
# end
module CitizensAdviceCookiePreferences
  module Helpers
    extend ActiveSupport::Concern

    # rubocop:disable Metrics/BlockLength
    included do
      before_action :set_cookie_preferences, :check_cookie_version
      helper_method :cookies_preference_page?, :allow_analytics_cookies?, :allow_video_players_cookies?, :how_we_use_cookies_url,
                    :pref_page_url

      def cookies_preference_page?
        false
      end

      def allow_analytics_cookies?
        CitizensAdviceCookiePreferences::CurrentCookies.analytics?
      end

      def allow_video_players_cookies?
        CitizensAdviceCookiePreferences::CurrentCookies.video_players?
      end

      def how_we_use_cookies_url
        return "/cymraeg/amdanom-ni/gwybodaeth/sut-rydym-yn-defnyddio-cwcis/" if welsh_language?

        country = params[:country]

        if country.nil? || country == "england"
          "/about-us/information/how-we-use-cookies/"
        elsif country == "scotland"
          "/scotland/about-us/information/privacy-and-cookies-scotland/"
        elsif country == "wales"
          "/wales/about-us/information/how-we-use-cookies/"
        end
      end

      def pref_page_url
        return "/cymraeg/cookie-preferences/?cookie_prefs_return_url=#{CGI.escape(set_cookie_prefs_return_url)}" if welsh_language?

        country = params[:country]

        if country.nil? || country == "england"
          "/cookie-preferences/?cookie_prefs_return_url=#{CGI.escape(set_cookie_prefs_return_url)}"
        else
          "/#{country}/cookie-preferences/?cookie_prefs_return_url=#{CGI.escape(set_cookie_prefs_return_url)}"
        end
      end
    end
    # rubocop:enable Metrics/BlockLength

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
      cookies.delete(:cookie_preference_set, domain: :all)

      CookieManagement.new(cookies).delete_unconsented_cookies!
    end

    private

    def welsh_language?
      params[:locale] == "cy"
    end

    def set_cookie_prefs_return_url
      return unless request.host.ends_with?("citizensadvice.org.uk") || request.host.ends_with?("localhost")

      request.url
    end
  end
end
