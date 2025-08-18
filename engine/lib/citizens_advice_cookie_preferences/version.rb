# frozen_string_literal: true

module CitizensAdviceCookiePreferences
  VERSION = "0.1.0"
  COOKIE_CURRENT_VERSION = "1"

  COOKIE_CATEGORIES = {
    "_public_website_frontend_session" => "essential",
    "_smart_meter_tool_session" => "essential",
    "_demo_session" => "essential",
    "_content_platform_forms_session" => "essential",
    "_energy_apps_session" => "essential",
    "_dd_s" => "essential",
    "_forms_key" => "essential",
    "_grecaptcha" => "essential",
    "activeChat" => "essential",
    "amazon-connect-*" => "essential",
    "amazon-connect-session-*" => "essential",
    "cobrowse-storage_expiration-22834971" => "essential",
    "CustomizationObject" => "essential",
    "cwr_s" => "essential",
    "cwr_u" => "essential",
    "eprivacy" => "essential",
    "lpLastVisit-*" => "essential",
    "lpPmCalleeDfs" => "essential",
    "LPSID-*" => "essential",
    "lpTabId" => "essential",
    "LPVID" => "essential",
    "persistedChatSession" => "essential",
    "X-Source" => "essential",
    "_ga" => "analytics",
    "_ga_*" => "analytics",
    "ar_debug" => "analytics",
    "ethnio_displayed" => "analytics",
    "geo" => "analytics",
    "mf_*" => "analytics",
    "mf_initialDomQueue" => "analytics",
    "mf_transmitQueue" => "analytics",
    "mf_user" => "analytics",
    "mouseflow" => "analytics"
  }.freeze
end
