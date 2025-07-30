# frozen_string_literal: true

Given("I have previously accepted all cookies") do
  visit "/"
  within(".cookie-banner") do
    click_button "Accept additional cookies"
  end
  visit "/cookie-preferences/cookie_preference/edit"
end

Given("I have previously rejected all cookies") do
  visit "/"
  within(".cookie-banner") do
    click_button "Reject additional cookies"
  end
  visit "/cookie-preferences/cookie_preference/edit"
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
  if text == "analytics"
    label = "Reject analytics cookies"
  elsif text == "video_players"
    label = "Reject video players cookies"
  end

  expect(page).to have_checked_field label
end

Then("the accept {string} radio button is checked") do |text|
  if text == "analytics"
    label = "Accept analytics cookies"
  elsif text == "video_players"
    label = "Accept video players cookies"
  end

  expect(page).to have_checked_field label
end
