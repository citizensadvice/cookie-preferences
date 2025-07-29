# frozen_string_literal: true

Given("I am on the Demo App Home page") do
  visit "/"
end

Given("I am on the cookie preference page") do
  visit "/cookie-preferences/cookie_preference"
end


And("I visit another page") do
  visit "/show-page"
end

Then("I should see {string}") do |text|
  expect(page).to have_content(text)
end
