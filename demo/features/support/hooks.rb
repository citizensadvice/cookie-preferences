# frozen_string_literal: true

After do |test_case|
  Capybara.current_session.save_screenshot("cucumber-results/screenshots/#{test_case.name}.png") if test_case.failed?
end
