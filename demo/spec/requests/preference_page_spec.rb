# frozen_string_literal: true

require "rails_helper"

# rubocop:disable RSpecRails/InferredSpecType
# rubocop:disable Layout/LineLength
RSpec.describe "Preference page", type: :request do
  context "when the request country is England" do
    before { get "/cookie-preferences/edit" }

    it "renders the application template" do
      expect(response).to render_template(layout: "application")
    end

    it "render the england how we use cookies page link" do
      expect(response.body).to include("/about-us/information/how-we-use-cookies/")
    end
  end

  context "when the request country is Wales" do
    before { get "/wales/cookie-preferences/edit" }

    it "renders the application template" do
      expect(response).to render_template(layout: "application")
    end

    it "render the wales how we use cookies page link" do
      expect(response.body).to include("/wales/about-us/information/how-we-use-cookies/")
    end
  end

  context "when the request country is Scotland" do
    before { get "/scotland/cookie-preferences/edit" }

    it "renders the application template" do
      expect(response).to render_template(layout: "public_website_scotland")
    end

    it "render the scotland how we use cookies page link" do
      expect(response.body).to include("/scotland/about-us/information/privacy-and-cookies-scotland/")
    end
  end

  context "when Welsh language request" do
    before { get "/cymraeg/cookie-preferences/edit" }

    it "renders the application template" do
      expect(response).to render_template(layout: "application")
    end

    it "render the Welsh how we use cookies page link" do
      expect(response.body).to include("/cymraeg/amdanom-ni/gwybodaeth/sut-rydym-yn-defnyddio-cwcis/")
    end
  end

  describe "ReturnUrl as a url param" do
    context "when unknown url in params" do
      before { get "/cookie-preferences/edit?ReturnUrl=http%3A%2F%2Fevilurl.com%2F" }

      it "filters out the value from the hidden ReturnUrl field" do
        expect(response.body).to include "<input autocomplete=\"off\" type=\"hidden\" name=\"cookie_preference[ReturnUrl]\" id=\"cookie_preference_ReturnUrl\" />"
      end
    end

    context "when subdomain" do
      before { get "/cookie-preferences/edit?ReturnUrl=https%3A%2F%2Fsmartmetercheck.citizensadvice.org.uk%2F" }

      it "includes the subdomain as in the value of the hidden ReturnUrl field" do
        expect(response.body).to include "<input value=\"https://smartmetercheck.citizensadvice.org.uk/\" autocomplete=\"off\" type=\"hidden\" name=\"cookie_preference[ReturnUrl]\" id=\"cookie_preference_ReturnUrl\" />"
      end
    end

    context "when public citizensadvice domain" do
      before { get "/cookie-preferences/edit?ReturnUrl=https%3A%2F%2Fwww.citizensadvice.org.uk%2Fimmigration" }

      it "includes the citizensadvice domain in the value of the hidden ReturnUrl field" do
        expect(response.body).to include "<input value=\"https://www.citizensadvice.org.uk/immigration\" autocomplete=\"off\" type=\"hidden\" name=\"cookie_preference[ReturnUrl]\" id=\"cookie_preference_ReturnUrl\" />"
      end
    end

    context "when localhost" do
      before { get "/cookie-preferences/edit?ReturnUrl=http%3A%2F%2Flocalhost%3A3000%2Fimmigration" }

      it "includes the localhost domain in the value of the hidden ReturnUrl field" do
        expect(response.body).to include "<input value=\"http://localhost:3000/immigration\" autocomplete=\"off\" type=\"hidden\" name=\"cookie_preference[ReturnUrl]\" id=\"cookie_preference_ReturnUrl\" />"
      end
    end

    context "when the ReturnUrl doesn't have a host" do
      before { get "/cookie-preferences/edit?ReturnUrl=%2Flaw-and-courts" }

      it "include the hidden ReturnUrl field has no value" do
        expect(response.body).to include "<input autocomplete=\"off\" type=\"hidden\" name=\"cookie_preference[ReturnUrl]\" id=\"cookie_preference_ReturnUrl\" />"
      end
    end

    context "when the ReturnUrl is not ASCII-encoded" do
      # NB: params passed separately to avoid RSpec helpers raising the exception we're trying to test for!
      before { get "/cookie-preferences/edit", params: { ReturnUrl: "https://example.citizensadvice.org.uk/cysylltwch-\u00E2-ni/" } }

      it "includes a correctly-encoded URL to link back to" do
        expect(response.body).to include "<input value=\"https://example.citizensadvice.org.uk/cysylltwch-%C3%A2-ni/\" autocomplete=\"off\" type=\"hidden\" name=\"cookie_preference[ReturnUrl]\" id=\"cookie_preference_ReturnUrl\" />"
      end
    end

    context "when the hidden field value is modified" do
      before do
        patch "/cookie-preferences/", params: { cookie_preference: { analytics: "false", video_players: "false", ReturnUrl: "http://evilurl.com/" } }
      end

      it "includes the citizensadvice domain in the value of the hidden ReturnUrl field" do
        follow_redirect!
        expect(response.body).not_to include "<a href=\"http://evilurl.com/\">Go back to the page you were looking at</a>"
      end
    end
  end
end
# rubocop:enable RSpecRails/InferredSpecType
# rubocop:enable Layout/LineLength
