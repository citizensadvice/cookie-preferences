# frozen_string_literal: false

require "rails_helper"

RSpec.describe "CitizensAdviceCookiePreferences::Helpers" do
  controller do
    include CitizensAdviceCookiePreferences::Helpers

    def test_action
      # We need to set the variable here because the CurrentCookies.preference attribute resets after the request finishes
      @analytics_value = allow_analytics_cookies?
      head :ok
    end
  end

  before do
    routes.draw { get "/test_action" => "anonymous#test_action" }
  end

  describe "#allow_analytics_cookies?" do
    context "when the cookie is malformed" do
      before do
        controller.request.cookies[:cookie_preference] = "I am not valid JSON"
        # We need to set cookie_preference_set so that check_cookie_version id skipped
        # otherwise it will run reset_cookie_consent, and we won't react the rescue block of set_cookie_preferences
        controller.request.cookies[:cookie_preference_set] = "2"

        get :test_action
      end

      it "returns true after resetting to default preferences" do
        expect(controller.instance_variable_get(:@analytics_value)).to be(true)
      end
    end
  end
end
