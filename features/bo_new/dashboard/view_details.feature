@bo_new @upper_tier @bo_dashboard @wip
Feature: NCCC agent views new back office dashboard
  As an NCCC agent
  I want to view registration and renewal details on one service
  So that I can quickly answer user queries

@smoke
Scenario: NCCC user creates registration and renewal, and checks status
  Given an Environment Agency user has signed in to the backend
   When NCCC partially registers an "upper" tier "carrier_broker_dealer" "limitedCompany" with "no convictions"
    And the applicant pays by bank card
    And NCCC finishes the registration
   Then the back office pages show the correct registration details

  Given there is an existing registration
   When NCCC partially renews an existing registration with "no convictions"
   Then the back office pages show the correct transient renewal details

  Given NCCC goes back to the in progress renewal
   When the applicant pays by bank card
   Then the renewal is complete
    And the back office pages show the correct registration details

# Add payment by bank transfer and check status
# Add convictions check and check status, when convictions story is ready for registrations
