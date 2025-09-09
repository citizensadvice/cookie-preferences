# frozen_string_literal: true

require "rails_helper"

RSpec.describe CitizensAdviceCookiePreferences::CookieBanner, type: :component do
  subject { page }

  let(:component) { described_class.new }

  before do
    allow(component).to receive_messages(how_we_use_cookies_url: "/some-url", pref_page_url: "/some-other-url")
    render_inline(component)
  end

  describe "CookieBanner" do
    context "when English language" do
      it { is_expected.to have_text "Cookies on Citizens Advice" }
    end

    context "when Welsh language" do
      around { |example| I18n.with_locale(:cy) { example.run } }

      it { is_expected.to have_text "Cwcis ar ein gwefan" }
    end
  end
end
