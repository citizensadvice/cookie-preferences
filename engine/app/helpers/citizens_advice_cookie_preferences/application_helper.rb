module CitizensAdviceCookiePreferences
  module ApplicationHelper
    def allow_non_essential_cookies?
      CitizensAdviceCookiePreferences::CurrentCookies.additional?
    end
  end
end
