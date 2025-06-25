# frozen_string_literal: true

require "json"

module CitizensAdviceCookiePreferences
  class CookiePreference
    include ActiveModel::Model
    include ActiveModel::Attributes
    include ActiveModel::Serializers::JSON

    attribute :analytics, :boolean, default: true

    def analytics_options
      [
        FormOption.new(id: "true", name: "Use cookies that measure my website use"),
        FormOption.new(id: "false", name: "Do not use cookies that measure my website use")
      ]
    end

    def persisted?
      true
    end
  end
end
