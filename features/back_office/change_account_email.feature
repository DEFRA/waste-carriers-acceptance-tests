@backoffice @functional @smoke @broken
Feature: Change the account email for registrations
As an agency user
I need to be able to change the account linked to a registration
So that users can continue to maintain registrations even if their details change

  Scenario: Change the account where user has just one registration
    Given an Environment Agency user has signed in
      And I have a registration "CBDU105"
     When I change the account email
     Then I see a confirmation the change has been made


  Scenario: Change the account where user has just multiple registrations
    Given the user has 2 registrations
      And an Environment Agency user has signed in
     When I change the account email for both
     Then I see a confirmation for both
