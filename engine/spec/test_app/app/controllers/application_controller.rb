# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include CitizensAdviceCookiePreferences::SetCookiePreferences

  def index; end
end
