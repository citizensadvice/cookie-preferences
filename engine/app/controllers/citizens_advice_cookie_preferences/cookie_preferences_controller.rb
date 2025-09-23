# frozen_string_literal: true

module CitizensAdviceCookiePreferences
  class CookiePreferencesController < ApplicationController
    default_form_builder CitizensAdviceComponents::FormBuilder

    DEFAULT_PREFERENCES = { essential: true, analytics: false, video_players: false }.freeze
    include Rails.application.routes.url_helpers

    before_action :set_default_cookie, only: :edit

    def show
      redirect_to localised_engine_namespace.edit_cookie_preference_path(country: params[:country],
                                                                         cookie_prefs_return_url: cookie_prefs_return_url)
    end

    def edit
      @return_url = formatted_return_url(cookie_prefs_return_url)
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
        redirect_to localised_engine_namespace.edit_cookie_preference_path
      else
        render :edit
      end
    end
    # rubocop:enable Metrics/AbcSize

    private

    def cookie_prefs_return_url
      params[:cookie_prefs_return_url] || request.referer

      if params[:cookie_prefs_return_url]
        params[:cookie_prefs_return_url]
      elsif valid_referer?
        request.referer
      end
    end

    def valid_referer?
      return false unless request.referer

      # First part is localhost
      # Second part is any CA subdomain
      uri = URI.parse(request.referer)
      return true if uri.host == request.host || uri.host.include?("citizensadvice.org.uk")

      false
    end

    def formatted_return_url(url)
      return unless url

      uri = URI.parse(url)

      if uri.query
        # When the back link is coming form request.referer rather than a param,
        # we need to extract it from the url param
        # E.g http://localhost:3000/cookie-preferences/edit?cookie_prefs_return_url=http%3A%2F%2Flocalhost%3A3000%2Fshow-page
        CGI.parse(uri.query)["cookie_prefs_return_url"][0]

      else
        # Don't return a formatted url if the user visited the cookie preferences page directly
        return if uri.path == localised_engine_namespace.edit_cookie_preference_path

        url
      end
    end

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
  end
end
