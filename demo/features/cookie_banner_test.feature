Feature: Cookie Banner

  Background:
    Given I am on the Demo App Home page

  Scenario: User accepts cookies
    When I click "Accept additional cookies"
    Then my cookie preference is saved
    And the essential cookies are accepted
    And the additional cookies are accepted


  Scenario: User rejects cookies
    When I click "Reject additional cookies"
    Then my cookie preference is saved
    And the essential cookies are accepted
    And the additional cookies are rejected

