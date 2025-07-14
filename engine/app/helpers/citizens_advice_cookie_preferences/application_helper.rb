module CitizensAdviceCookiePreferences
  module ApplicationHelper
    def allow_non_essential_cookies?
      JSON.parse(cookies[:cookie_preference])["additional_cookies"]
    end
  end
end
