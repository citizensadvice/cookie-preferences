# frozen_string_literal: true

require "rails_helper"

# rubocop:disable RSpecRails/InferredSpecType
# rubocop:disable RSpecRails/Layout/LineLength
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
# rubocop:enable RSpecRails/Layout/LineLength
