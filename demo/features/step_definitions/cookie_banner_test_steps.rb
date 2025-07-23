# frozen_string_literal: true

When("I click the {string} button") do |text|
  within(".cookie-banner") do
    click_button text
  end
end

Then("the essential cookies are accepted") do
  cookie_preference = cookie_preference_helper
  expect(cookie_preference["essential"]).to be true
end

Then("my cookie preference is saved") do
  cookie_preference_set = cookie_preference_set_helper
  expect(cookie_preference_set[:value]).to eq "true"
end

Then("my cookie preferences are not set") do
  cookie_preference_set = cookie_preference_set_helper
  expect(cookie_preference_set).to be nil
end

Then("the additional cookies are accepted") do
  cookie_preference = cookie_preference_helper
  expect(cookie_preference["additional"]).to be true
end

Then("the additional cookies are rejected") do
  cookie_preference = cookie_preference_helper
  expect(cookie_preference["additional"]).to be false
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

def cookie_preference_helper
  complete_cookie = page.driver.browser.manage.all_cookies.find { |cookie| cookie[:name] == "cookie_preference" }
  JSON.parse(CGI.unescape(complete_cookie[:value]))
end

def cookie_preference_set_helper
  page.driver.browser.manage.all_cookies.find { |cookie| cookie[:name] == "cookie_preference_set" }
end
