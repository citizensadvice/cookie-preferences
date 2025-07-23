# frozen_string_literal: true

When("I click the {string} button") do |text|
  within(".cookie-banner") do
    click_button text
  end
end

Then("the essential cookies are accepted") do
  cookie_preference = page.driver.browser.manage.all_cookies.find{|cookie| cookie[:name] == "cookie_preference"}
  cookie_values = JSON.parse(CGI.unescape(cookie_preference[:value]))
  expect(cookie_values["essential"]).to be true
end

Then('my cookie preference is saved') do
  cookie_preference_set = page.driver.browser.manage.all_cookies.find{|cookie| cookie[:name] == "cookie_preference_set"}
  expect(cookie_preference_set[:value]).to eq "true"
end

Then('the additional cookies are accepted') do
  cookie_preference = page.driver.browser.manage.all_cookies.find{|cookie| cookie[:name] == "cookie_preference"}
  cookie_values = JSON.parse(CGI.unescape(cookie_preference[:value]))
  expect(cookie_values["additional"]).to be true
end

Then("I should see {string}") do |text|
  expect(page).to have_content(text)
end