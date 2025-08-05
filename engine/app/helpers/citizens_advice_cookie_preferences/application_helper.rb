# frozen_string_literal: true

module CitizensAdviceCookiePreferences
  module ApplicationHelper
    def allow_analytics_cookies?
      CitizensAdviceCookiePreferences::CurrentCookies.analytics?
    end

    def allow_video_players_cookies?
      CitizensAdviceCookiePreferences::CurrentCookies.video_players?
    end
  end
end
