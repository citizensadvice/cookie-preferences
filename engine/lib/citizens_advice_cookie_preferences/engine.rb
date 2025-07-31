# frozen_string_literal: true

module CitizensAdviceCookiePreferences
  class Engine < ::Rails::Engine
    isolate_namespace CitizensAdviceCookiePreferences

    initializer "citizens_advice_cookie_preferences.assets.precompile" do |app|
      app.config.assets.precompile += %w( cookies.css cookies.js )
    end
  end
end
