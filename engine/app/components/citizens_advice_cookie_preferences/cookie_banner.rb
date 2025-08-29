# frozen_string_literal: true

module CitizensAdviceCookiePreferences
  class CookieBanner < ViewComponent::Base
    def base_button_classes
      %w[
        cads-button
        cads-button__primary
      ]
    end
  end
end
