@bo_new @bo_dashboard @smoke
Feature: NCCC agent edits registration from back office
  As an NCCC agent
  I want to edit the details of a registration
  So that we can correctly regulate the waste activity

  Background:
    Given I have an active registration

  Scenario: NCCC user edits an upper tier registration
    When I sign into the back office as "agency-user"
    And I edit the most recent registration
    And I confirm the changes
    Then I can see the changes on the registration details page
    And the registration's balance is 0

    When I sign into the back office as "agency-user"
    And I edit the most recent registration type to "broker_dealer"
    And I confirm the changes
    And I pay by card
    Then I can see the changes on the registration details page
    And the registration's balance is 0

    When I sign into the back office as "agency-user"
    And I edit the most recent registration type to "carrier_broker_dealer"
    And I confirm the changes
    And I pay by bank transfer
    Then I can see the changes on the registration details page
    And the registration's balance is 40

    When I sign into the back office as "agency-user"
    And I edit the most recent registration
    And I cancel the edit
    Then I cannot see the changes on the registration details page
