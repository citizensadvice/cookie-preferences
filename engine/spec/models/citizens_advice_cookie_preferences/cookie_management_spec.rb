# frozen_string_literal: true

require "rails_helper"

RSpec.describe CitizensAdviceCookiePreferences::CookieManagement do
  subject(:cookie_management) { described_class.new(cookies_hash) }

  let(:cookies_hash) { ActiveSupport::HashWithIndifferentAccess.new(cookies) }

  let(:cookies) do
    {
      _demo_session: "something",
      ethnio_displayed: "something",
      cookie_preference: { essential: true, analytics: false }.to_json,
      evil_tracking_cookie: "muhaha",
      _ga_wildcard: "something"
    }
  end

  it "does not delete essential cookies" do
    cookie_management.delete_unconsented_cookies!

    expect(cookie_management.cookies).to include("_demo_session", "cookie_preference")
  end

  it "deletes analytics cookies" do
    cookie_management.delete_unconsented_cookies!

    expect(cookie_management.cookies).not_to include("ethnio_displayed", "_ga_wildcard")
  end

  it "deletes unexpected cookies" do
    cookie_management.delete_unconsented_cookies!

    expect(cookie_management.cookies).not_to include("evil_tracking_cookie")
  end

  context "with user consent for analytics cookies" do
    let(:cookies) do
      {
        cookie_preference: { analytics: true }.to_json,
        ethnio_displayed: "something"
      }
    end

    it "does not delete analytics cookies" do
      cookie_management.delete_unconsented_cookies!

      expect(cookie_management.cookies).to include("ethnio_displayed")
    end
  end
end
