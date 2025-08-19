# frozen_string_literal: true

require "rails_helper"

RSpec.describe CitizensAdviceCookiePreferences::CookieManagement do
  subject(:cookie_management) { described_class.new(cookies_hash).delete_unconsented_cookies! }

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
    expect(cookie_management).to include("_demo_session", "cookie_preference")
  end

  it "deletes analytics cookies" do
    expect(cookie_management).not_to include("ethnio_displayed", "_ga_wildcard")
  end

  it "deletes unexpected cookies" do
    expect(cookie_management).not_to include("evil_tracking_cookie")
  end

  context "user has consented to analytics cookies" do
    let(:cookies) do
      {
        cookie_preference: { analytics: true }.to_json,
        ethnio_displayed: "something"
      }
    end

    it "does not delete analytics cookies" do
      expect(cookie_management).to include("ethnio_displayed")
    end
  end
end
