module CitizensAdviceCookiePreferences
  class CookiePreferencesController < ApplicationController
    default_form_builder CitizensAdviceComponents::FormBuilder

    DEFAULT_PREFERENCES = { "essential_cookies": true, "additional_cookies": false }.freeze

    include Rails.application.routes.url_helpers

    before_action :set_default_cookie, only: :edit

    def show
      redirect_to citizens_advice_cookie_preferences.edit_cookie_preference_path
    end

    def edit
      @cookie_preferences = CookiePreference.new(prefs_from_cookie)
    end

    def update
      # binding.pry
      @cookie_preferences = CookiePreference.new(additional_cookies: prefs_from_form['additional_cookies'])

      if @cookie_preferences.valid?
        cookies[:cookie_preference] = {
          value: @cookie_preferences.serializable_hash.to_json,
          expires: 1.year,
          domain: :all
        }
        cookies[:cookie_preference_set] = {
          value: true,
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
  end
end
