# frozen_string_literal: true

module CitizensAdviceCookiePreferences
  module ApplicationHelper
    def cookies_preferences_page?
      request.path == "/cookie-preferences/cookie_preference/edit"
    end
  end
end
