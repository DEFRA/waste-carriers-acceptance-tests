@backoffice @ts
Feature: Change the account email for registrations
As an agency user
I need to be able to change the account linked to a registration
So that users can continue to maintain registrations even if their details change

  Scenario: Change the account where user has just one registration
    Given an Environment Agency user has signed in
      And I choose to transfer ownership of "CBDU234" to another user
      And I have signed into the renewals service as an agency user
     When I change the account email to "user@example.com"
     Then I see a confirmation the change has been made

