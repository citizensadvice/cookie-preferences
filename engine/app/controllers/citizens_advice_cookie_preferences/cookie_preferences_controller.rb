# frozen_string_literal: true

module CitizensAdviceCookiePreferences
  class CookiePreferencesController < ApplicationController
    default_form_builder CitizensAdviceComponents::FormBuilder

    DEFAULT_PREFERENCES = { essential: true, analytics: false, video_players: false }.freeze
    include Rails.application.routes.url_helpers

    before_action :set_default_cookie, only: :edit

    def show
      redirect_to localised_engine_namespace.edit_cookie_preference_path(country: params[:country],
                                                                         cookie_prefs_return_url: params[:cookie_prefs_return_url])
    end

    def edit
      @cookie_prefs_return_url = set_cookie_prefs_return_url(params[:cookie_prefs_return_url])
      @localised_engine_namespace = localised_engine_namespace
      @current_country = params[:country]
      @page_title = t("cookie_preferences.title")
      @page_description = t("cookie_preferences.description")
      @cookie_preferences = CookiePreference.new(prefs_from_cookie)
    end

    # rubocop:disable Metrics/AbcSize
    def update
      @cookie_preferences = CookiePreference.new(analytics: prefs_from_form["analytics"], video_players: prefs_from_form["video_players"])

      if @cookie_preferences.valid?
        update_cookie_preferences
        CookieManagement.new(cookies).delete_unconsented_cookies!
        flash[:notice] = t("cookie_preferences.update.success")

        cookie_prefs_return_url = params[:cookie_preference][:cookie_prefs_return_url]
        redirect_to localised_engine_namespace.edit_cookie_preference_path(cookie_prefs_return_url: cookie_prefs_return_url)
      else
        render :edit
      end
    end
    # rubocop:enable Metrics/AbcSize

    private

    def prefs_from_form
      params.fetch(:cookie_preference).permit(:analytics, :video_players, :cookie_prefs_return_url)
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

    def update_cookie_preferences
      cookies[:cookie_preference] = {
        value: @cookie_preferences.serializable_hash.to_json,
        expires: 1.year,
        domain: :all
      }
      cookies[:cookie_preference_set] = {
        value: COOKIE_CURRENT_VERSION,
        expires: 1.year,
        domain: :all
      }
    end

    def localised_engine_namespace
      case params[:locale]
      when "en"
        citizens_advice_cookie_preferences_en
      when "cy"
        citizens_advice_cookie_preferences_cy
      else
        citizens_advice_cookie_preferences
      end
    end

    def set_cookie_prefs_return_url(url)
      return if url.blank?

      parsed_url = URI.parse(url)

      return unless parsed_url.host.ends_with?(".citizensadvice.org.uk") || parsed_url.host == "localhost"

      url
    end
  end
end
