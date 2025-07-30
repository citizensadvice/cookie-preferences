And("I visit a page that uses the cookie helpers") do
  visit "/show-page"
end

Then("I see see a message that the {string} cookies are accepted") do |text|
  expect(page).to have_text("This text appears if the #{text} cookies have been accepted.")
end

Then("I see see a message that the {string} cookies are rejected") do |text|
  expect(page).to have_text("This text appears if the #{text} cookies have been rejected.")
end