@bo_new @bo_dashboard
Feature: NCCC agent unblocks a registration from back office
  As an NCCC agent
  I want to unblock a registration using a back office function
  So that I can allow the customer to complete their application

This test will not work if Worldpay mocking is turned on as it relies on the user stopping the journey on the WorldPay page.

# Background:
#   Given I start a new registration
#    And I complete my application of my limited company as an upper tier waste carrier using my email "user@example.com"
#    And I pay for my application by maestro ordering 0 copy cards
#    And I have signed in the front office using my email
#    And I start renewing my last registration from the frontend
#    And I complete my limited liability partnership renewal steps and get stuck
#
# Scenario: NCCC unblocks a stuck renewal registration
#   Given I sign into the back office as "agency-user"
#     And I revert the last renewal to payment summary
#   Then the user is able to complete their renewal

# Scenario: NCCC unblock a stuck new registration
  # pending implementation
