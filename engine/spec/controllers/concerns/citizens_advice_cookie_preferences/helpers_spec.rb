# frozen_string_literal: false

require "rails_helper"

RSpec.describe "CitizensAdviceCookiePreferences::Helpers" do
  controller do
    include CitizensAdviceCookiePreferences::Helpers

    def test_action
      head :ok
    end
  end

  before do
    routes.draw { get "/test_action" => "anonymous#test_action" }
  end

  describe "#allow_analytics_cookies?" do
    subject { controller.helpers.allow_analytics_cookies? }

    context "when the cookie is malformed" do
      before do
        controller.request.cookies[:cookie_preference] = "I am not valid JSON"

        get :test_action
      end

      it { is_expected.to be(false) }
    end
  end
end
