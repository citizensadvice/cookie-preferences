# frozen_string_literal: false

require "rails_helper"

RSpec.describe CitizensAdviceCookiePreferences::ApplicationHelper do
  describe "#allow_analytics_cookies?" do
    it "returns true when analytics cookies have been accepted" do
      accept_additional_cookies
      cookies_preference_parsed = JSON.parse(cookies[:cookie_preference])
      CitizensAdviceCookiePreferences::CurrentCookies.preference = cookies_preference_parsed

      expect(helper.allow_analytics_cookies?).to be(true)
    end

    it "returns false when analytics cookies have been rejected" do
      reject_additional_cookies
      cookies_preference_parsed = JSON.parse(cookies[:cookie_preference])
      CitizensAdviceCookiePreferences::CurrentCookies.preference = cookies_preference_parsed

      expect(helper.allow_analytics_cookies?).to be(false)
    end

    it "returns false if the analytics cookies have not been set" do
      expect(helper.allow_analytics_cookies?).to be(false)
    end
  end

  describe "#allow_video_players_cookies?" do
    it "returns true when video_players cookies have been accepted" do
      accept_additional_cookies
      cookies_preference_parsed = JSON.parse(cookies[:cookie_preference])
      CitizensAdviceCookiePreferences::CurrentCookies.preference = cookies_preference_parsed

      expect(helper.allow_video_players_cookies?).to be(true)
    end

    it "returns false when video_players cookies have been rejected" do
      reject_additional_cookies
      cookies_preference_parsed = JSON.parse(cookies[:cookie_preference])
      CitizensAdviceCookiePreferences::CurrentCookies.preference = cookies_preference_parsed

      expect(helper.allow_video_players_cookies?).to be(false)
    end

    it "returns false if the video_players cookies have not been set" do
      expect(helper.allow_video_players_cookies?).to be(false)
    end
  end

  private

  def accept_additional_cookies
    cookies[:cookie_preference] = {
      value: { essential: true, analytics: true, video_players: true }.to_json,
      expires: 1.year,
      domain: :all
    }
  end

  def reject_additional_cookies
    cookies[:cookie_preference] = {
      value: { essential: true, analytics: false, video_players: false }.to_json,
      expires: 1.year,
      domain: :all
    }
  end
end
