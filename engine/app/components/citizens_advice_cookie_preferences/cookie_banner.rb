# frozen_string_literal: true

module CitizensAdviceCookiePreferences
  class CookieBanner < ViewComponent::Base

    def initialize(current_country:)
      @current_country = current_country
    end

    def country_url
      "/#{@current_country}/cookie-preferences"
    end
    def base_button_classes
      %w[
        cads-button
        cads-button__primary
      ]
    end
  end
end
