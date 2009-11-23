Feature: User login
As a user
I want to login
So that I can access cvbeast

  Scenario: An activated user successfully logs in
    Given an active user exists with email: "ajsharp@gmail.com"
    When I go to the user login page
    And I fill in "Email" with "ajsharp@gmail.com"
    And I fill in "Password" with "password"
    And I press "Log In"
    Then I should see "Login successful!"
    And I should be on the user dashboard page

  Scenario: A pending user unsuccessfully logs in
    Given a user waiting activation exists with email: "user@wherever.com"
    When I go to the user login page
    And I fill in "Email" with "user@wherever.com"
    And I fill in "Password" with "secret"
    And I press "Log In"
    Then I should see "Your account is not active" within ".errorExplanation"
