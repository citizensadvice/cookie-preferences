# frozen_string_literal: true

require "rails_helper"

RSpec.describe CitizensAdviceCookiePreferences::CurrentCookies do
  subject(:current_cookies) { described_class.new }

  let(:preference) { nil }

  before do
    current_cookies.preference = preference
  end

  describe "#analytics?" do
    it "returns false when no cookies are set" do
      expect(current_cookies.analytics?).to be false
    end

    context "with analytics cookies accepted" do
      let(:preference) { { "essential" => true, "analytics" => true, "video_players" => false } }

      it "returns true when the analytics cookie is true" do
        expect(current_cookies.analytics?).to be true
      end
    end

    context "with analytics cookies rejected" do
      let(:preference) { { "essential" => true, "analytics" => false, "video_players" => false } }

      it "returns false when the analytics cookie is false" do
        expect(current_cookies.analytics?).to be false
      end
    end
  end

  describe "#video_players?" do
    it "returns false when no cookies are set" do
      expect(current_cookies.video_players?).to be false
    end

    context "with video_players cookies accepted" do
      let(:preference) { { "essential" => true, "analytics" => false, "video_players" => true } }

      it "returns true when the video_players cookie is true" do
        expect(current_cookies.video_players?).to be true
      end
    end

    context "with video_players cookies rejected" do
      let(:preference) { { "essential" => true, "analytics" => false, "video_players" => false } }

      it "returns false when the video_players cookie is false" do
        expect(current_cookies.video_players?).to be false
      end
    end
  end
end
