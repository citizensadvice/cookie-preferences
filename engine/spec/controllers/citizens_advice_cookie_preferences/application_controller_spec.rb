# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationController do
  controller do
    include CitizensAdviceCookiePreferences::Helpers

    def index
      render plain: "I like cookies!"
    end
  end

  before do
    request.cookies[:cookie_preference] = preference.to_json
    get :index
  end

  let(:preference) { nil }

  describe "#analytics?" do
    it "returns false when no cookies are set" do
      expect(controller.helpers.allow_analytics_cookies?).to be false
    end

    context "with analytics cookies accepted" do
      let(:preference) { { "essential" => true, "analytics" => true, "video_players" => false } }

      it "returns true when the analytics cookie is true" do
        expect(controller.helpers.allow_analytics_cookies?).to be true
      end
    end

    context "with analytics cookies rejected" do
      let(:preference) { { "essential" => true, "analytics" => false, "video_players" => false } }

      it "returns false when the analytics cookie is false" do
        expect(controller.helpers.allow_analytics_cookies?).to be false
      end
    end
  end

  describe "#video_players?" do
    it "returns false when no cookies are set" do
      expect(controller.helpers.allow_video_players_cookies?).to be false
    end

    context "with video_players cookies accepted" do
      let(:preference) { { "essential" => true, "analytics" => false, "video_players" => true } }

      it "returns true when the video_players cookie is true" do
        expect(controller.helpers.allow_video_players_cookies?).to be true
      end
    end

    context "with video_players cookies rejected" do
      let(:preference) { { "essential" => true, "analytics" => false, "video_players" => false } }

      it "returns false when the video_players cookie is false" do
        expect(controller.helpers.allow_video_players_cookies?).to be false
      end
    end
  end
end
