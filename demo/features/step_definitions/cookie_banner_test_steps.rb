# frozen_string_literal: true

Given("I am on the Demo App England show page") do
  visit "/show-page"
end

Then("I can see a link to the cookie preferences page for England") do
  expect(page).to have_link("Find out more about how we use cookies and keep your data safe",
                            href: "/cookie-preferences/?ReturnUrl=http%3A%2F%2Flocalhost%3A3000%2Fshow-page")
end

Then("I can see the short link to the cookie preferences page for England") do
  expect(page).to have_link("change your cookie settings",
                            href: "/cookie-preferences/?ReturnUrl=http%3A%2F%2Flocalhost%3A3000%2Fshow-page")
end

Given("I am on the Demo App Wales show page") do
  visit "/wales/show-page"
end

Then("I can see a link to the cookie preferences page for Wales") do
  expect(page).to have_link("Find out more about how we use cookies and keep your data safe",
                            href: "/wales/cookie-preferences/?ReturnUrl=http%3A%2F%2Flocalhost%3A3000%2Fwales%2Fshow-page")
end

Then("I can see the short link to the cookie preferences page for Wales") do
  expect(page).to have_link("change your cookie settings",
                            href: "/wales/cookie-preferences/?ReturnUrl=http%3A%2F%2Flocalhost%3A3000%2Fwales%2Fshow-page")
end

Given("I am on the Demo App Scotland show page") do
  visit "/scotland/show-page"
end

Then("I can see a link to the cookie preferences page for Scotland") do
  expect(page).to have_link("Find out more about how we use cookies and keep your data safe",
                            href: "/scotland/cookie-preferences/?ReturnUrl=http%3A%2F%2Flocalhost%3A3000%2Fscotland%2Fshow-page")
end

Then("I can see the short link to the cookie preferences page for Scotland") do
  expect(page).to have_link("change your cookie settings",
                            href: "/scotland/cookie-preferences/?ReturnUrl=http%3A%2F%2Flocalhost%3A3000%2Fscotland%2Fshow-page")
end

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
  expect(page).to have_no_text("We'd also like to use some additional cookies to:")
end

And("the javascript cookie banner is rendered") do
  expect(page).to have_text("We'd also like to use some additional cookies to:")
  expect(page).to have_no_text("It looks like you have JavaScript turned off.")
end
