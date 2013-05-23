@atag
Feature: Login
  In order to use the application
  as a potential user
  I want to login the system.



  Background:
    Given I have installed the application
    And My user has been setup
  


  @module1 @module2
  Scenario: Single login
  
    Given I open the application
    When I enter the user name "<username>"
    And I enter the password "<password>"
    And I push the "Login" button
    Then I should be successfully login
    And I should be redirected to the main window


  
  Scenario Outline: Login
  
    Given I open the application
    When I enter the user name "<username>"
    And I enter the password "<password>"
    And I push the "Login" button
    Then I should <result_1>
    And I should <result_2>

    Examples: Successful Login

    | username | password    | result_1              | result_2                         |  
    | vieyal01 | 12344       | be successfully login | be redirected to the main window |  
    | user02   | Password123 | be successfully login | be redirected to the main window |  
    | user22   | lalala      | be successfully login | be redirected to the main window |  


    Examples: Login Fail

    | username | password      | result_1             | result_2         |  
    | vieyal02 | 12344         | see an error message | not be logged in |  
    | user02   | Passwoasrd123 | see an error message | not be logged in |  
    | user2s2  | lala23la      | see an error message | not be logged in | 
