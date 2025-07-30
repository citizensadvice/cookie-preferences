# test structure
# set cookie_preference cookie
# trigger before action
# expect CurrentCookie.preference to equal json parsed version of the cookie value that we saved

require "rails_helper"

RSpec.describe "SetCookiePreferences concern" do

  before do
    # This links to the application controller in test app
    # if the approach works, we can make a separate controller for this test
    @controller = ApplicationController.new
  end

  it 'assigns CitizensAdviceCookiePreferences::CurrentCookies.preference to be the json parsed version of the cookie value' do
    accept_additional_cookies
    get :index
    # At this stage, we have a value for cookies[:cookie_preference]
    cookies_preference_parsed = JSON.parse(cookies[:cookie_preference])
    # Initially added - allow(CitizensAdviceCookiePreferences::CurrentCookies).to receive(:preference)
    # And then also tried with to receive and return - but this would defeat the purpose of writing this test as it can work without the concern being called
    # CitizensAdviceCookiePreferences::CurrentCookies.preference is nil here, even though set_cookie_preferences has been called
    expect(CitizensAdviceCookiePreferences::CurrentCookies.preference).to eq(cookies_preference_parsed)
  end

  private

  def accept_additional_cookies
    cookies[:cookie_preference] = {
      value: { essential: true, analytics: true, video_players: true }.to_json,
      expires: 1.year,
      domain: :all
    }
  end
end