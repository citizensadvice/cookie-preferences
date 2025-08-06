Feature: Cookie Helpers

  Background:
    Given I am on the Demo App Home page

  Scenario: Default cookies are set
  I visit the site and haven't interacted with the cookie banner
    And I visit a page that uses the cookie helpers

  Scenario: User accepts cookies
    When I click the "Accept additional cookies" button
    And I visit a page that uses the cookie helpers
    Then I see a message that the "analytics" cookies are accepted
    And I see a message that the "video_players" cookies are accepted

  Scenario: User rejects cookies
    When I click the "Reject additional cookies" button
    And I visit a page that uses the cookie helpers
    Then I see a message that the "analytics" cookies are rejected
    And I see a message that the "video_players" cookies are rejected