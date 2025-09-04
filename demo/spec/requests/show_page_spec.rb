# frozen_string_literal: true

require "rails_helper"

# rubocop:disable RSpecRails/InferredSpecType
RSpec.describe "Show page", type: :request do
  context "when the request country is England" do
    before { get "/show-page" }

    it "renders the England how we use cookies page link" do
      expect(response.body).to include("/about-us/information/how-we-use-cookies/")
    end

    it "renders the England cookies preference page link" do
      expect(response.body).to include("/cookie-preferences")
    end
  end

  context "when the request country is Wales" do
    before { get "/wales/show-page" }

    it "renders the Wales how we use cookies page link" do
      expect(response.body).to include("/wales/about-us/information/how-we-use-cookies/")
    end

    it "renders the Wales cookies preference page link" do
      expect(response.body).to include("/wales/cookie-preferences")
    end
  end

  context "when the request country is Scotland" do
    before { get "/scotland/show-page" }

    it "renders the Scotland how we use cookies page link" do
      expect(response.body).to include("/scotland/about-us/information/privacy-and-cookies-scotland/")
    end

    it "renders the Scotland cookies preference page link" do
      expect(response.body).to include("/scotland/cookie-preferences")
    end
  end
end
# rubocop:enable RSpecRails/InferredSpecType
