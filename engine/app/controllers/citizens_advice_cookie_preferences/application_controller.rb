# frozen_string_literal: true

module CitizensAdviceCookiePreferences
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    # TODO: make it configurable per app
    # public-website application
    layout "application"

    helper_method :homepage_url

    def homepage_url
      if request.params[:country].present?
        main_app.extent_root_path(country: request.params[:country])
      else
        main_app.root_path
      end
    end
  end
end
