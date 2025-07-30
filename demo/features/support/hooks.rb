# frozen_string_literal: true

After do |test_case|
  if test_case.failed?
    path = "demo/cucumber-results/screenshots/#{test_case.name}.png"
    Rails.log.info("Taking a screenshot to #{path}")
    Capybara.current_session.save_screenshot(path)
    attach(path, "image/png")
  end
end
