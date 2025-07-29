# frozen_string_literal: true

module CitizensAdviceCookiePreferences
  class CurrentCookies < ActiveSupport::CurrentAttributes
    attribute :preference

    def analytics?
      if preference.present?
        preference.fetch("analytics", false)
      else
        false
      end
    end

    def video_players?
      if preference.present?
        preference.fetch("video_players", false)
      else
        false
      end
    end
  end
end
