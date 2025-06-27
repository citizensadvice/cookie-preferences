module CitizensAdviceCookiePreferences
  class CookiePreferencesController < ApplicationController
    default_form_builder CitizensAdviceComponents::FormBuilder

    DEFAULT_PREFERENCES = { "additional_cookies" => false }.freeze

    include Rails.application.routes.url_helpers

    def show
      redirect_to citizens_advice_cookie_preferences.edit_cookie_preference_path
    end

    def edit
      @cookie_preferences = CookiePreference.new(additional_cookies: prefs_from_cookie["additional_cookies"])
    end

    def update
      @cookie_preferences = CookiePreference.new(additional_cookies: prefs_from_form["additional_cookies"])

      if @cookie_preferences.valid?
        cookies[:cookie_preference] = {
          value: @cookie_preferences.serializable_hash,
          expires: 1.year,
          domain: :all
        }
      end

      render :edit
    end

    private

    def prefs_from_form
      params.fetch(:cookie_preference).permit(:additional_cookies)
    end

    def prefs_from_cookie
      # At the moment, cookie_preference returns "{\"additional_cookies\"=>false}"
      # this parsing will result in {"additional_cookies"=>false}
      if cookies[:cookie_preference].present?
        JSON.parse(cookies[:cookie_preference].gsub('=>', ':'))
      else
        DEFAULT_PREFERENCES
      end
    end
  end
end