Feature: Cookie Success Message

  Scenario: User navigates to the preferences page from the cookie banner
    Given I am on the Demo App England show page
    And I click the "Choose cookies" link
    And I click to save my choices
    Then I can see the success message with a return url

  Scenario: User navigates to the preferences page from a link on a page
    Given I am on the Demo App England show page
    And I click the "Off we go to the preference page" link
    And I click to save my choices
    Then I can see the success message without a return url

  Scenario: User navigates to the preferences page directly
    Given I am on the cookie preference page
    And I click to save my choices
    Then I can see the success message without a return url