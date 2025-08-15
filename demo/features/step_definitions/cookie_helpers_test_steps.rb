# frozen_string_literal: true

And("I visit a page that uses the cookie helpers") do
  visit "/helpers-page"
end

Then("I see a message that the {string} cookies are accepted") do |text|
  expect(page).to have_text("This text appears if the #{text} cookies have been accepted.")
end

Then("I see a message that the {string} cookies are rejected") do |text|
  expect(page).to have_text("This text appears if the #{text} cookies have been rejected.")
end

And("I have a boatload of cookies") do
  page.driver.browser.manage.add_cookie({ name: "mouseflow", value: "mouseflow_cookie" })
  page.driver.browser.manage.add_cookie({ name: "mf_1", value: "mouseflow_cookie_1" })
  page.driver.browser.manage.add_cookie({ name: "_ga_135m04mh2", value: "ga_cookie" })
  page.driver.browser.manage.add_cookie({ name: "ar_debug", value: "ar_debug_cookie" })
  page.driver.browser.manage.add_cookie({ name: "ethnio_displayed", value: "ethnio_cookie" })
  page.driver.browser.manage.add_cookie({ name: "geo", value: "geo_cookie" })
  page.driver.browser.manage.add_cookie({ name: ".CitizensAdviceLogin", value: "legacy_login_cookie" })
end

Then("the non-essential cookies are deleted") do
  expect(page.driver.browser.manage.all_cookies.find { |cookie| cookie[:name] == "mouseflow" }).to be_nil
  expect(page.driver.browser.manage.all_cookies.find { |cookie| cookie[:name] == "ethnio_displayed" }).to be_nil
end

And("the essential cookies are not deleted") do
  expect(page.driver.browser.manage.all_cookies.find { |cookie| cookie[:name] == "cookie_preference" }).not_to be_nil
end

And("the non-approved cookies are deleted") do
  expect(page.driver.browser.manage.all_cookies.find { |cookie| cookie[:name] == ".CitizensAdviceLogin" }).to be_nil
end
