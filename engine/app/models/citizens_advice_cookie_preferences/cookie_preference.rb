# frozen_string_literal: true

require "json"

module CitizensAdviceCookiePreferences
  class CookiePreference
    include ActiveModel::Model
    include ActiveModel::Attributes
    include ActiveModel::Serializers::JSON

    attribute :additional_cookies, :boolean, default: false

    def additional_cookies_options
      [
        FormOption.new(id: "true", name: "Accept additional cookies"),
        FormOption.new(id: "false", name: "Reject additional cookies")
      ]
    end

    def persisted?
      true
    end
  end
end
