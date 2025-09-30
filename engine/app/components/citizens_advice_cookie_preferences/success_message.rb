# frozen_string_literal: true

module CitizensAdviceCookiePreferences
  class SuccessMessage < ViewComponent::Base
    attr_reader :message, :return_url

    def initialize(message:, return_url: nil)
      super()
      @message = message
      @return_url = return_url
    end

    def render?
      message.present?
    end
  end
end
