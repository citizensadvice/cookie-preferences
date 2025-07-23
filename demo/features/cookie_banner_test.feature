Feature: Cookie Banner

  Background:
    Given I am on the Demo App Home page

  Scenario: Default cookies are set
    I visit the site and haven't interacted with the cookie banner
    Then the essential cookies are accepted
    And the analytics cookies are rejected
    And the video player cookies are rejected
    And my cookie preferences are not set

  Scenario: User accepts cookies
    When I click the "Accept additional cookies" button
    Then my cookie preference is saved
    Then the essential cookies are accepted
    And the analytics cookies are accepted
    And the video player cookies are accepted

  Scenario: User rejects cookies
    When I click the "Reject additional cookies" button
    Then my cookie preference is saved
    And the essential cookies are accepted
    And the analytics cookies are rejected
    And the video player cookies are rejected

  Scenario: User hides the cookie banner
    Given I have set my cookie preferences
    When I click the "Hide this message" button
    Then the cookie banner is no longer visible

  Scenario: User sets their cookie preference and visits another page
    Given I have set my cookie preferences
    And I visit another page
    Then the cookie banner is no longer visible

  Scenario: User does not set their cookie preference and visits another page
    Given I visit another page
    Then the cookie banner is visible
