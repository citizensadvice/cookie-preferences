# frozen_string_literal: true

module CitizensAdviceCookiePreferences
  class CookieBanner < ViewComponent::Base
    delegate :how_we_use_cookies_url, to: :helpers

    def initialize(current_country:)
      super()
      @current_country = current_country.downcase
    end

    def country_url
      @current_country == "england" ? "/cookie-preferences" : "/#{@current_country}/cookie-preferences"
    end

    def base_button_classes
      %w[
        cads-button
        cads-button__primary
      ]
    end
  end
end
