# frozen_string_literal: true

# Utility for including shared view and controller helpers
# class ApplicationController < ActionController::Base
#   include CitizensAdviceCookiePreferences::Helpers
#   [...]
# end
module CitizensAdviceCookiePreferences
  module Helpers
    extend ActiveSupport::Concern

    attr_reader :cookie_preferences

    included do
      before_action :set_cookie_preferences

      helper_method :allow_analytics_cookies?
      def allow_analytics_cookies?
        if cookie_preferences.present?
          cookie_preferences.fetch("analytics", false)
        else
          false
        end
      end

      helper_method :allow_video_players_cookies?
      def allow_video_players_cookies?
        if cookie_preferences.present?
          cookie_preferences.fetch("video_players", false)
        else
          false
        end
      end
    end

    protected

    def set_cookie_preferences
      return if cookies[:cookie_preference].blank?

      @cookie_preferences = JSON.parse(cookies[:cookie_preference])
    end
  end
end
