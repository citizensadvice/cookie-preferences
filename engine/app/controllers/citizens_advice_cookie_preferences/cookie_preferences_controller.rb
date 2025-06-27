module CitizensAdviceCookiePreferences
  class CookiePreferencesController < ApplicationController
    default_form_builder CitizensAdviceComponents::FormBuilder

    DEFAULT_PREFERENCES = { "additional_cookies" => true }.freeze

    include Rails.application.routes.url_helpers

    def show
      redirect_to citizens_advice_cookie_preferences.edit_cookie_preference_path
    end

    def edit
      @cookie_preferences = CookiePreference.new do |pref|
        pref.additional_cookies = prefs_from_cookie["additional_cookies"]
      end
    end

    def update
      @cookie_preferences = CookiePreference.new(additional_cookies: prefs_from_form["additional_cookies"])

      cookies[:cookie_preference] = @cookie_preferences.serializable_hash if @cookie_preferences.valid?

      render :edit
    end

    private

    def prefs_from_form
      params.fetch(:cookie_preference).permit(:additional_cookies)
    end

    def prefs_from_cookie
      JSON.parse(cookies[:cookie_preference]) || DEFAULT_PREFERENCES
    end
  end
end