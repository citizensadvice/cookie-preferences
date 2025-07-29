# frozen_string_literal: false

require "rails_helper"

RSpec.describe CitizensAdviceCookiePreferences::ApplicationHelper do
  describe "#allow_analytics_cookies?" do
    it "returns true when CurrentCookies.analytics? is true" do
      allow(CitizensAdviceCookiePreferences::CurrentCookies).to receive(:analytics?).and_return(true)

      expect(helper.allow_analytics_cookies?).to be(true)
    end

    it "returns false when CurrentCookies.analytics? is false" do
      allow(CitizensAdviceCookiePreferences::CurrentCookies).to receive(:analytics?).and_return(false)

      expect(helper.allow_analytics_cookies?).to be(false)
    end
  end

  describe "#allow_video_players_cookies?" do
    it "returns true when CurrentCookies.video_players? is true" do
      allow(CitizensAdviceCookiePreferences::CurrentCookies).to receive(:video_players?).and_return(true)

      expect(helper.allow_video_players_cookies?).to be(true)
    end

    it "returns false when CurrentCookies.video_players? is false" do
      allow(CitizensAdviceCookiePreferences::CurrentCookies).to receive(:video_players?).and_return(false)

      expect(helper.allow_video_players_cookies?).to be(false)
    end
  end
end
