@bo_new @upper_tier @bo_dashboard @smoke @wip
Feature: NCCC agent edits registration from back office
  As an NCCC agent
  I want to edit the details of a registration
  So that we can correctly regulate the waste activity

Background:
  Given an Environment Agency user has signed in to the backend
   When NCCC partially registers an upper tier "carrier_broker_dealer" "limitedCompany" with "no convictions"
    And the applicant pays by bank card
    And NCCC finishes the registration

Scenario: NCCC user edits an upper tier registration
  Given I sign into the back office as "agency-user"
   When I edit the most recent registration
    And I confirm the changes
   Then I can see the changes on the registration details page
    And the registration's balance is 0

  Given I sign into the back office as "agency-user"
   When I edit the most recent registration type to "carrier_dealer"
    And I confirm the changes
    And I pay by card
   Then I can see the changes on the registration details page
    And the registration's balance is 0

  Given I sign into the back office as "agency-user"
   When I edit the most recent registration type to "carrier_broker_dealer"
    And I confirm the changes
    And I pay by bank transfer
   Then I can see the changes on the registration details page
    And the registration's balance is 40

  Given I sign into the back office as "agency-user"
   When I edit the most recent registration
    And I cancel the edit
   Then I cannot see the changes on the registration details page
