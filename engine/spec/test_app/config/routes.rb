# frozen_string_literal: true

Rails.application.routes.draw do
  mount CitizensAdviceCookiePreferences::Engine => "/engine"
end
