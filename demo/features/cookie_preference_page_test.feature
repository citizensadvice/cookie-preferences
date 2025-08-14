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
    And the no javascript preference page callout is not rendered

  Scenario: I accept only the analytics cookies
    When I click to accept "analytics" cookies
    And I click to save my choices
    Then the accept "analytics" radio button is checked
    And the reject "video_players" radio button is checked
    And the essential cookies are accepted
    And the analytics cookies are accepted
    And the video player cookies are rejected
    And my cookie preference is saved
    And the version number is set

  Scenario: I accept only the video players cookies
    When I click to accept "video_players" cookies
    And I click to save my choices
    Then the reject "analytics" radio button is checked
    And the accept "video_players" radio button is checked
    And the essential cookies are accepted
    And the analytics cookies are rejected
    And the video player cookies are accepted
    And my cookie preference is saved
    And the version number is set

  Scenario: I have previously accepted all cookies
    Given I have previously accepted all cookies
    Then the accept "analytics" radio button is checked
    And the accept "video_players" radio button is checked
    And the essential cookies are accepted
    And the analytics cookies are accepted
    And the video player cookies are accepted
    And my cookie preference is saved
    And the version number is set

  Scenario: I reject the analytics and video players cookies
    Given I have previously accepted all cookies
    When I click to reject "analytics" cookies
    And I click to reject "video_players" cookies
    And I click to save my choices
    Then the reject "analytics" radio button is checked
    And the reject "video_players" radio button is checked
    And the essential cookies are accepted
    And the analytics cookies are rejected
    And the video player cookies are rejected
    And my cookie preference is saved
    And the version number is set

  Scenario: I accept the analytics and video players cookies
    Given I have previously rejected all cookies
    When I click to accept "analytics" cookies
    And I click to accept "video_players" cookies
    And I click to save my choices
    Then the accept "analytics" radio button is checked
    And the accept "video_players" radio button is checked
    And the essential cookies are accepted
    And the analytics cookies are accepted
    And the video player cookies are accepted
    And my cookie preference is saved
    And the version number is set

  @no_js
  Scenario: User does not have javascript
    Then the no javascript preference page callout is rendered

  Scenario: I have all my analytics cookies deleted
    Given I have previously consented to cookies and have a boatload of them
    Then I am on the cookie preference page
    Then all the analytics cookies are deleted
