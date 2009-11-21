Feature: User account activation
As a user
I want to activate my account
So that I can login

  Scenario: A pending user succesfully accesses the set password page
    Given user exists with email: "user@example.com"
    When the user with email "user@example.com" goes to his activation page
    Then I should see "Set your password"
