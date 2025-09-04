# frozen_string_literal: true

module CitizensAdviceCookiePreferences
  class ApplicationController < ::ApplicationController
    protect_from_forgery with: :exception

    # TODO: make it configurable per app
    # public-website application
    layout :layout_type

    def layout_type
      request.params[:country] == "scotland" ? "public_website_scotland" : "application"
    end
  end
end
