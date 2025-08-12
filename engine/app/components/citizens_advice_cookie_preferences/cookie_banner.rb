# frozen_string_literal: true

module CitizensAdviceCookiePreferences
  class CookieBanner < ViewComponent::Base
    def accept_all_cookies_button_classes
      base_button_classes << "gtm-accept-all-cookies"
    end

    def reject_all_cookies_button_classes
      base_button_classes << "gtm-reject-all-cookies"
    end

    def base_button_classes
      %w[
      cads-button
      cads-button__primary
    ]
    end
  end
end
