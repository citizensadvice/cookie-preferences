# frozen_string_literal: true

module CitizensAdviceCookiePreferences
  class CurrentCookies < ActiveSupport::CurrentAttributes
    attribute :preference

    def analytics?
      preference ? preference.fetch("analytics", false) : false
    end

    def video_players?
      preference ? preference.fetch("video_players", false) : false
    end
  end
end
