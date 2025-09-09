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
        FormOption.new(id: "true", name: I18n.t("cookie_preferences.form.analytic_cookies_options.accept")),
        FormOption.new(id: "false", name: I18n.t("cookie_preferences.form.analytic_cookies_options.reject"))
      ]
    end

    def video_players_cookies_options
      [
        FormOption.new(id: "true", name: I18n.t("cookie_preferences.form.video_player_cookies_options.accept")),
        FormOption.new(id: "false", name: I18n.t("cookie_preferences.form.video_player_cookies_options.reject"))
      ]
    end

    def persisted?
      true
    end
  end
end
