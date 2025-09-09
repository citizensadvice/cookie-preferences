Feature: Cookies engine Welsh Translation

  Scenario: User visits the Welsh Home page for the first time
    Given I am on the Demo App Welsh Home page
    Then the Welsh cookie banner is visible

  Scenario: User navigates to the Welsh cookie preferences page
    Given I am on the Demo App Welsh Home page
    And I click the Welsh cookie preferences page link
    Then I am taken to the Welsh version of the cookie preferences page