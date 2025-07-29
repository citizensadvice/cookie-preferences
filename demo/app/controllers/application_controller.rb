# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include CitizensAdviceComponents::Helpers
  helper CitizensAdviceCookiePreferences::ApplicationHelper
  include CitizensAdviceCookiePreferences::CookiePreferencesHelpers
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protected

  def cads_default_breadcrumbs
    [{ title: "Home", url: home_path }]
  end
end
