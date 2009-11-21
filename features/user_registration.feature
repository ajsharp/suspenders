Feature: User account registration
As a new user
I want to create a new account
So that I can access the site

  Scenario: A user successfully creates an account
    When I go to the new user page
    And I fill in "Email" with "user@example.com"
    And I press "Sign Up!"
    Then I should see "Your account has been created. Please check your e-mail for your account activation instructions!"

