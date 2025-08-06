# frozen_string_literal: true

module CitizensAdviceCookiePreferences
  class CookiePreferencesController < ApplicationController
    default_form_builder CitizensAdviceComponents::FormBuilder

    DEFAULT_PREFERENCES = { essential: true, analytics: false, video_players: false }.freeze
    VERSION_NUM = "1"

    include Rails.application.routes.url_helpers

    before_action :set_default_cookie, only: :edit

    def show
      redirect_to citizens_advice_cookie_preferences.edit_cookie_preference_path
    end

    def edit
      @cookie_preferences = CookiePreference.new(prefs_from_cookie)
    end

    def update
      @cookie_preferences = CookiePreference.new(analytics: prefs_from_form["analytics"], video_players: prefs_from_form["video_players"])

      if @cookie_preferences.valid?
        cookies[:cookie_preference] = {
          value: @cookie_preferences.serializable_hash.to_json,
          expires: 1.year,
          domain: :all
        }
        cookies[:cookie_preference_set] = {
          value: VERSION_NUM,
          expires: 1.year,
          domain: :all
        }
      end

      render :edit
    end

    private

    def prefs_from_form
      params.fetch(:cookie_preference).permit(:analytics, :video_players)
    end

    def prefs_from_cookie
      if cookies[:cookie_preference].present?
        JSON.parse(cookies[:cookie_preference])
      else
        DEFAULT_PREFERENCES
      end
    end

    def set_default_cookie
      return if cookies[:cookie_preference].present?

      cookies[:cookie_preference] = {
        value: DEFAULT_PREFERENCES.to_json,
        expires: 1.year,
        domain: :all
      }
    end

    def cookies_preference_page?
      true
    end
  end
end
