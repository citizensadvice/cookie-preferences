module CitizensAdviceCookiePreferences
  class CookiePreferencesController < ApplicationController
    default_form_builder CitizensAdviceComponents::FormBuilder

    DEFAULT_PREFERENCES = { "analytics" => true }.freeze

    include Rails.application.routes.url_helpers

    def show
      redirect_to citizens_advice_cookie_preferences.edit_cookie_preference_path
    end

    def edit
      @cookie_preferences = CookiePreference.new do |pref|
        pref.analytics = prefs_from_cookie["analytics"]
      end
    end

    def update
      @cookie_preferences = CookiePreference.new(analytics: prefs_from_form["analytics"])

      cookies[:cookie_preference] = @cookie_preferences.serializable_hash if @cookie_preferences.valid?

      render :edit
    end

    private

    def prefs_from_form
      params.fetch(:cookie_preference).permit(:analytics)
    end

    def prefs_from_cookie
      JSON.parse(cookies[:cookie_preference]) || DEFAULT_PREFERENCES
    end
  end
end