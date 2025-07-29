Feature: Cookie Preference Page

  Background:
    Given I am on the cookie preference page

  Scenario: Default cookies are set
  I visit the site and haven't interacted with the cookie banner
    Then the reject "analytics" radio button is checked
    And the reject "video_players" radio button is checked

  Scenario: Analytics is accepted, video players is rejected

  Scenario: Analytics is rejected, video players is accepted

  Scenario: I accept all cookies
    Given
    Then the accept "analytics" radio button is checked
    And the accept "video_players" radio button is checked

  Scenario: Analytics is rejected, video players is rejected