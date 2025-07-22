# frozen_string_literal: true

Given("I am on the Demo App Home page") do
  visit "/"
end

Then("I should see {string}") do |text|
  expect(page).to have_content(text)
end
