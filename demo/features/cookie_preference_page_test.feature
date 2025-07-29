Feature: Cookie Preference Page

  Background:
    Given I am on the cookie preference page

  Scenario: Default cookies are set
  I visit the site and haven't interacted with the cookie banner
    Then the cookie banner is not visible
    And the reject "analytics" radio button is checked
    And the reject "video_players" radio button is checked
    And the essential cookies are accepted
    And the analytics cookies are rejected
    And the video player cookies are rejected
    And my cookie preferences are not set

  Scenario: Analytics is accepted, video players is rejected
    When I click to accept "analytics" cookies
    And I click to save my choices
    Then the accept "analytics" radio button is checked
    And the reject "video_players" radio button is checked
    And the essential cookies are accepted
    And the analytics cookies are accepted
    And the video player cookies are rejected
    And my cookie preference is saved

  Scenario: Analytics is rejected, video players is accepted
    When I click to accept "video_players" cookies
    And I click to save my choices
    Then the reject "analytics" radio button is checked
    And the accept "video_players" radio button is checked
    And the essential cookies are accepted
    And the analytics cookies are rejected
    And the video player cookies are accepted
    And my cookie preference is saved

  Scenario: I accept all cookies
    Given I am on the Demo App Home page
    When I click the "Accept additional cookies" button
    Then I am on the cookie preference page
    Then the accept "analytics" radio button is checked
    And the accept "video_players" radio button is checked
    And the essential cookies are accepted
    And the analytics cookies are accepted
    And the video player cookies are accepted
    And my cookie preference is saved

  Scenario: Analytics is rejected, video players is rejected
    Given I am on the Demo App Home page
    When I click the "Accept additional cookies" button
    Then I am on the cookie preference page
    When I click to reject "analytics" cookies
    And I click to reject "video_players" cookies
    And I click to save my choices
    Then the reject "analytics" radio button is checked
    And the reject "video_players" radio button is checked
    And the essential cookies are accepted
    And the analytics cookies are rejected
    And the video player cookies are rejected
    And my cookie preference is saved