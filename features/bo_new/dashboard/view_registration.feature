@bo_new @upper_tier @bo_dashboard
Feature: NCCC agent views new back office dashboard
  As an NCCC agent
  I want to view registration and renewal details on one service
  So that I can quickly answer user queries

Scenario: NCCC user creates registration and checks status
  Given an Environment Agency user has signed in
   When NCCC registers an "upper" tier "carrier_broker_dealer" "limitedCompany" with "no convictions"
   Then the back office pages show the correct registration details

# Next:

# Scenario: NCCC user creates renewal and checks status
#   Given an Environment Agency user has signed in to complete a renewal
#    When NCCC renews an "upper" tier "carrier_broker_dealer" "soleTrader" with "no convictions"
#    Then the back office pages show the correct transient renewal details
#     And the back office pages show the correct registration details

# Add payment by bank transfer and check status
# Add convictions check and check status
