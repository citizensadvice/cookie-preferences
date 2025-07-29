# frozen_string_literal: true

# When("I click the {string} button") do |text|
#   within(".cookie-banner") do
#     click_button text
#   end
# end

Then("the cookie banner is not visible") do
  expect(page).to have_no_css(".cookie-banner")
end

Then("the reject {string} radio button is checked") do |text|
  radio_button = find("#cookie_preference_#{text}_false", visible:false)
  expect(radio_button.checked?).to be true
end

Then("the accept {string} radio button is checked") do |text|
  radio_button = find("#cookie_preference_#{text}_true", visible:false)
  expect(radio_button.checked?).to be true
end