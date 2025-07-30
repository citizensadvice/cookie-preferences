# test structure
# set cookie_preference cookie
# trigger before action
# expect CurrentCookie.preference to equal json parsed version of the cookie value that we saved

require "rails_helper"

RSpec.describe "SetCookiePreferences concern" do

  controller(ApplicationController) do
    include CitizensAdviceCookiePreferences::SetCookiePreferences

    def fake_action; redirect_to '/an_url'; end
  end

  before do
    routes.draw {
      get 'fake_action' => 'anonymous#fake_action'
    }

    accept_additional_cookies
    get :fake_action
  end

  it 'my_method_to_test' do
    # allow(CitizensAdviceCookiePreferences::CurrentCookies).to receive(:preference)
    binding.pry
    cookies_preference_parsed = JSON.parse(cookies[:cookie_preference])
    expect(CitizensAdviceCookiePreferences::CurrentCookies.preference).to eq(cookies_preference_parsed)
  end

  def accept_additional_cookies
    cookies[:cookie_preference] = {
      value: { essential: true, analytics: true, video_players: true }.to_json,
      expires: 1.year,
      domain: :all
    }
  end
end