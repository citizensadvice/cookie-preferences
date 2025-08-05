# frozen_string_literal: true

require "json"

module CitizensAdviceCookiePreferences
  class CookiePreference
    include ActiveModel::Model
    include ActiveModel::Attributes
    include ActiveModel::Serializers::JSON

    attribute :essential, :boolean, default: true
    attribute :analytics, :boolean, default: false
    attribute :video_players, :boolean, default: false

    def analytics_cookies_options
      [
        FormOption.new(id: "true", name: "Accept analytics cookies"),
        FormOption.new(id: "false", name: "Reject analytics cookies")
      ]
    end

    def video_players_cookies_options
      [
        FormOption.new(id: "true", name: "Accept video players cookies"),
        FormOption.new(id: "false", name: "Reject video players cookies")
      ]
    end

    def persisted?
      true
    end
  end
end
