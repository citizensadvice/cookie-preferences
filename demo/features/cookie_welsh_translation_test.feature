Feature: Cookies engine Welsh Translation

  Scenario: User visits the Welsh Home page for the first time
    Given I am on the Demo App Welsh Home page
    Then the Welsh cookie banner is visible

  Scenario: User navigates to the Welsh cookie preferences page
    Given I am on the Demo App Welsh Home page
    And I click the Welsh cookie preferences page link
    Then I am taken to the Welsh version of the cookie preferences page

  Scenario: User accepts additional cookies and sees a link to the cookie preferences page
    Given I am on the Demo App Welsh Home page
    When I click the "Derbyn pob cwci ychwanegol" button
    Then I can see a link to the Welsh version of the cookie preferences page

  Scenario: User rejects additional cookies and has the correct link to the cookie preferences page
    Given I am on the Demo App Welsh Home page
    When I click the "Gwrthod pob cwci ychwanegol" button
    Then I can see a link to the Welsh version of the cookie preferences page