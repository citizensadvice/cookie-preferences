module CitizensAdviceCookiePreferences
  class CookiePreferencesPageController < ::ApplicationController # Inherits from the main application
    # TODO: make it configurable per app
    # public-website application
    layout "application"

    helper_method :homepage_url

    # Fixing issues with main app routes going to the engine
    include Rails.application.routes.url_helpers

    def index; end

    def homepage_url
      if request.params[:country].present?
        main_app.extent_root_path(country: request.params[:country])
      else
        main_app.root_path
      end
    end
  end
end