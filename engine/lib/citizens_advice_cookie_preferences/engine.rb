module CitizensAdviceCookiePreferences
  class Engine < ::Rails::Engine
    isolate_namespace CitizensAdviceCookiePreferences

    # tried precompiling assets to see if that made the JS available for public-website - from https://guides.rubyonrails.org/engines.html#separate-assets-and-precompiling
    initializer 'citizens_advice_cookie_preferences.assets.precompile' do |app|
      app.config.assets.precompile += %w( cookie-banner.js application.scss )
    end

  end
end
