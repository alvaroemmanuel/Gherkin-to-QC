Feature: Login
  In order to use the application
  as a potential user
  I want to login the system.
  
  
  Scenario: Login
  
    Given I open the application
    When I enter the user name "<username>"
    And I enter the password "<password>"
    And I push the "Login" button
    Then I should be successfully login
    And I should be redirected to the main window