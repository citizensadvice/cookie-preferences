# frozen_string_literal: true

module CitizensAdviceCookiePreferences
  class CookieBanner < ViewComponent::Base
    delegate :how_we_use_cookies_url, :pref_page_url, to: :helpers

    def base_button_classes
      %w[
        cads-button
        cads-button__primary
      ]
    end
  end
end
