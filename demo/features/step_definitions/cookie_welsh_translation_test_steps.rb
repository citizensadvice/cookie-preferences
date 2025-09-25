# frozen_string_literal: true

Given("I am on the Demo App Welsh Home page") do
  visit "/cymraeg"
end

Then("the Welsh cookie banner is visible") do
  expect(page).to have_text("Rydym yn defnyddio cwcis hanfodol i sicrhau bod ein gwefan yn gweithio'n iawn")
  expect(page).to have_link("ddysgu mwy am y cwcis rydym yn eu defnyddio",
                            href: "/cymraeg/amdanom-ni/gwybodaeth/sut-rydym-yn-defnyddio-cwcis/")
  expect(page).to have_link("Dewiswch gwcis",
                            href: "/cymraeg/cookie-preferences/?cookie_prefs_return_url=http%3A%2F%2Flocalhost%3A3000%2Fcymraeg")
end

And("I click the Welsh cookie preferences page link") do
  click_link "Dewiswch gwcis"
end

Then("I am taken to the Welsh version of the cookie preferences page") do
  expect(page).to have_text("Eich gosodiadau cwcis")
  expect(page).to have_link("weld rhestr lawn o'r holl gwcis rydym yn eu defnyddio",
                            href: "/cymraeg/amdanom-ni/gwybodaeth/sut-rydym-yn-defnyddio-cwcis/")
end

Then("I can see a link to the Welsh version of the cookie preferences page") do
  expect(page).to have_link("newid gosodiadau eich cwcis",
                            href: "/cymraeg/cookie-preferences/?cookie_prefs_return_url=http%3A%2F%2Flocalhost%3A3000%2Fcymraeg")
end
