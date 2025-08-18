# frozen_string_literal: true

Given("I have previously accepted all cookies") do
  visit "/"
  within(".cookie-banner") do
    click_button "Accept additional cookies"
  end
  visit "/cookie-preferences"
end

Given("I have previously rejected all cookies") do
  visit "/"
  within(".cookie-banner") do
    click_button "Reject additional cookies"
  end
  visit "/cookie-preferences"
end

When("I click to reject {string} cookies") do |text|
  within(".edit_cookie_preference") do
    choose("cookie_preference[#{text}]", option: "false", visible: false)
  end
end

When("I click to accept {string} cookies") do |text|
  within(".edit_cookie_preference") do
    choose("cookie_preference[#{text}]", option: "true", visible: false)
  end
end

When("I click to save my choices") do
  within(".edit_cookie_preference") do
    click_button "Save changes"
  end
end

Then("the cookie banner is not visible") do
  expect(page).to have_no_css(".cookie-banner")
end

Then("the reject {string} radio button is checked") do |text|
  label = text == "analytics" ? "Reject analytics cookies" : "Reject video players cookies"
  expect(page).to have_checked_field(label, visible: :hidden)
end

Then("the accept {string} radio button is checked") do |text|
  label = text == "analytics" ? "Accept analytics cookies" : "Accept video players cookies"
  expect(page).to have_checked_field(label, visible: :hidden)
end

Then("the no javascript preference page callout is rendered") do
  expect(page).to have_text("You need JavaScript to accept or reject additional cookies.")
  expect(page).to have_no_text("Accept or reject video player cookies")
end

Then("the no javascript preference page callout is not rendered") do
  expect(page).to have_text("Accept or reject video player cookies")
  expect(page).to have_no_text("You need JavaScript to accept or reject additional cookies.")
end
