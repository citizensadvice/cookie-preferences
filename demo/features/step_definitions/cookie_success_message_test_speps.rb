# frozen_string_literal: true

And("I click the {string} link") do |link|
  click_link link
end

Then("I can see the success message with a return url") do
  expect(page).to have_text("Your cookie settings have been saved")
  expect(page).to have_link("Go back to the page you were looking at", href: "http://localhost:3000/show-page")
end

Then("I can see the success message without a return url") do
  expect(page).to have_text("Your cookie settings have been saved")
  expect(page).to have_no_link("Go back to the page you were looking at", href: "http://localhost:3000/show-page")
end
