Feature: User account activation
As a user
I want to activate my account
So that I can login

Background:
Given user exists with email: "user@example.com"

  Scenario: A pending user succesfully accesses the set password page
    When the user with email "user@example.com" goes to his activation page
    Then I should see "Set your password"

  Scenario: A pending user successfully sets his password and logs in
    When the user with email "user@example.com" goes to his activation page
    And I fill in "Password" with "secret"
    And I fill in "Password Confirmation" with "secret"
    And I press "Activate Account"
    Then I should see "Your account has been activated."
    And I should be on the user dashboard page
