@bo_new @bo_dashboard
Feature: Change the account email for registrations
As an agency user
I need to be able to change the account linked to a registration
So that users can continue to maintain registrations even if their details change

  Scenario: Change the account where user has just one registration
    Given I sign into the back office as "agency_user"
      And I choose to transfer ownership of "CBDU234" to another user
     When I change the account email to "user@example.com"
     Then I see a confirmation the change has been made