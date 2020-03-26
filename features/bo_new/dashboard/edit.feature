@bo_new @upper_tier @bo_dashboard @smoke
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
   When I edit the most recent registration # new. Suggest including random info in a variable to use in the edit, and check against this later
    And I confirm the changes # new
   Then I can see the changes on the registration details page # new but will be similar to "the back office pages show the correct registration details"

   When I edit the most recent registration
    And I cancel the edit # new
   Then I cannot see the changes on the registration details page # new
