module CitizensAdviceCookiePreferences
  class CurrentCookies < ActiveSupport::CurrentAttributes
    attribute :preference

    def additional?
      if preference.present?
        preference.fetch("additional_cookies", false)
      else
        false
      end
    end
  end
end