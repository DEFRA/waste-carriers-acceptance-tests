@bo @bo_dashboard @smoke
Feature: Change the account email for registrations
  As an agency user
  I need to be able to change the account linked to a registration
  So that users can continue to maintain registrations even if their details change

  Scenario: Change the account where user has just one registration
    Given I create a new registration as "another-user@example.com"
    And I sign into the back office as "agency-user"
    And I choose to transfer ownership of the registration to another user
    When I change the account email to "user@example.com"
    Then I see a confirmation the change has been made
