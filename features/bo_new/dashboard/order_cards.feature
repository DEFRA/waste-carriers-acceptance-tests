@bo_new @upper_tier @bo_dashboard
Feature: NCCC agent orders registration cards from back office
  As an NCCC agent
  I want to order registration cards
  So that I can help a waste carrier prove they are registered

Background:
	Given I sign into the back office as "agency_user"

Scenario: NCCC user orders one card by bank card
  When an agency user orders "1" registration card for "CBDU208"
   And the agency user pays for the card by bank card
  Then the card order is confirmed with cleared payment
   # And the carrier receives an email saying their card order is being printed

Scenario: NCCC user orders 3 cards by bank transfer
  When an agency user orders "3" registration cards for "CBDU208"
   And the agency user pays for the card by bank transfer
  Then the card order is confirmed awaiting payment
   # And the carrier receives an email saying they need to pay for their card order
