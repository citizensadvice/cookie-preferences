# frozen_string_literal: true

require "rails_helper"

# rubocop:disable RSpecRails/InferredSpecType
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
end
# rubocop:enable RSpecRails/InferredSpecType
