@bo @bo_dashboard
Feature: [RUBY-767] NCCC agent orders registration cards from back office
  As an NCCC agent
  I want to order registration cards
  So that I can help a waste carrier prove they are registered

  Background:
    Given I sign into the back office as "agency-user"

  @email
  Scenario: NCCC user orders one card by bank card
    Given I have an active registration
    When an agency user orders "1" registration card
    And the agency user pays for the card by bank card
    Then the card order is confirmed with cleared payment
    And the registration's balance is 0
    And the carrier receives an email saying their card order is being printed

  Scenario: NCCC orders card but payment is rejected
    Given I have an active registration with a company name of "Copy card - reject payment"
    When an agency user orders "1" registration card
    And I have my credit card payment rejected
    Then the payment is shown as rejected
