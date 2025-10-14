# frozen_string_literal: true

require "rails_helper"

RSpec.describe CitizensAdviceCookiePreferences::SuccessMessage, type: :component do
  subject { page }

  context "with default arguments" do
    before do
      render_inline described_class.new(message: "Your cookie settings have been saved")
    end

    it { is_expected.to have_css ".cads-success-message", text: "Your cookie settings have been saved" }

    it { is_expected.to have_css "[role=status]" }

    it { is_expected.to have_no_link "Go back to the page you were looking at" }
  end

  context "with return_url" do
    before do
      render_inline described_class.new(message: "Your cookie settings have been saved", return_url: "/some-page")
    end

    it { is_expected.to have_link "Go back to the page you were looking at", href: "/some-page" }
  end

  context "when no message present" do
    before { render_inline described_class.new(message: nil) }

    it { is_expected.to have_no_css ".cads-success-message" }
  end
end
