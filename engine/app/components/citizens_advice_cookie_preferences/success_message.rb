# frozen_string_literal: true

module CitizensAdviceCookiePreferences
  class SuccessMessage < ViewComponent::Base
    attr_reader :message, :cookie_prefs_return_url

    def initialize(message:, cookie_prefs_return_url: nil)
      super()
      @message = message
      @cookie_prefs_return_url = cookie_prefs_return_url
    end

    def render?
      message.present?
    end
  end
end
