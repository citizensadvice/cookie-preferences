# frozen_string_literal: true

When("I click the {string} button") do |text|
  within(".cookie-banner") do
    click_button text
  end
end

Then("the essential cookies are accepted") do
  cookie_preference = cookie_value_helper("cookie_preference")
  expect(cookie_preference["essential"]).to be true
end

Then("my cookie preference is saved") do
  cookie_preference_set = cookie_metadata_helper("cookie_preference_set")
  expect(cookie_preference_set[:value]).to eq "true"
end

Then("my cookie preferences are not set") do
  cookie_preference_set = cookie_metadata_helper("cookie_preference_set")
  expect(cookie_preference_set).to be nil
end

Then("the analytics cookies are accepted") do
  cookie_preference = cookie_value_helper("cookie_preference")
  expect(cookie_preference["analytics"]).to be true
end

Then("the analytics cookies are rejected") do
  cookie_preference = cookie_value_helper("cookie_preference")
  expect(cookie_preference["analytics"]).to be false
end

Then("the video player cookies are accepted") do
  cookie_preference = cookie_value_helper("cookie_preference")
  expect(cookie_preference["video_players"]).to be true
end

Then("the video player cookies are rejected") do
  cookie_preference = cookie_value_helper("cookie_preference")
  expect(cookie_preference["video_players"]).to be false
end

Given("I have set my cookie preferences") do
  within(".cookie-banner") do
    click_button "Accept additional cookies"
  end
end

Then("the cookie banner is no longer visible") do
  expect(page).to have_css(".cookie-banner", visible: :hidden)
end

Then("the cookie banner is visible") do
  expect(page).to have_css(".cookie-banner", visible: :visible)
end

def cookie_value_helper(cookie_name)
  complete_cookie = page.driver.browser.manage.all_cookies.find { |cookie| cookie[:name] == cookie_name }
  JSON.parse(CGI.unescape(complete_cookie[:value]))
end

def cookie_metadata_helper(cookie_name)
  page.driver.browser.manage.all_cookies.find { |cookie| cookie[:name] == cookie_name }
end
