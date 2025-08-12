# frozen_string_literal: true

When("I click the {string} button") do |text|
  within(".cookie-banner") do
    click_button text
  end
end

Then("the cookie banner is no longer visible") do
  expect(page).to have_css(".cookie-banner", visible: :hidden)
end

Then("the cookie banner is visible") do
  expect(page).to have_css(".cookie-banner", visible: :visible)
end

Then("the cookie_preference domain is set") do
  cookie_preference = cookie_metadata_helper("cookie_preference")
  expect(cookie_preference[:domain]).to eq domain_helper
end

Then("the cookie_preference expiry is set for 1 year") do
  cookie_preference = cookie_metadata_helper("cookie_preference")
  expect(cookie_preference[:expires].to_date).to eq Time.zone.today.next_year
end

Given("I have previously consented to cookie version {string}") do |version|
  page.driver.browser.manage.add_cookie({ name: "cookie_preference_set", value: version })
end

Then("the no javascript cookie banner is rendered") do
  expect(page).to have_text("It looks like you have JavaScript turned off.")
  expect(page).to have_no_text("We'd also like to use additional cookies")
end

And("the javascript cookie banner is rendered") do
  expect(page).to have_text("We'd also like to use additional cookies")
  expect(page).to have_no_text("It looks like you have JavaScript turned off.")
end
