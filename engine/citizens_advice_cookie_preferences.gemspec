# frozen_string_literal: true

require_relative "lib/citizens_advice_cookie_preferences/version"

Gem::Specification.new do |spec|
  spec.name        = "citizens_advice_cookie_preferences"
  spec.version     = CitizensAdviceCookiePreferences::VERSION
  spec.authors     = ["Citizens Advice"]
  spec.homepage    = "https://github.com/citizensadvice/cookie-preferences"
  spec.summary     = "Citizens Advice cookie preferences engine"
  spec.description = "Rails engine containing cookie preference page, banner & helpers."
  spec.license     = "Apache-2.0"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    # spec.metadata["allowed_push_host"] = "https://rubygems.org"
    spec.metadata["rubygems_mfa_required"] = "true"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
          "public gem pushes."
  end

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/engine/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.1.0"
end
