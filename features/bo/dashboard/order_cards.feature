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

  @email 
  Scenario: NCCC user orders 3 cards by bank transfer
    Given I have an active registration
    When an agency user orders "3" registration cards
    And the agency user chooses to pay for the card by bank transfer
    Then the card order is confirmed awaiting payment
    And the registration has a status of "PAYMENT NEEDED"
    And the carrier receives an email saying they need to pay for their card order
    And the registration's balance is 15

    When NCCC makes a payment of 5 by "transfer"
    Then the registration has a status of "PAYMENT NEEDED"
    And the registration's balance is 10

    When NCCC makes a payment of 5 by "postal"
    Then the registration has a status of "PAYMENT NEEDED"
    And the registration's balance is 5

    When NCCC pays the remaining balance by "missed_worldpay"
    Then the registration does not have a status of "PAYMENT NEEDED"
    And the registration's balance is 0

  Scenario: NCCC orders card but payment is rejected
    Given I have an active registration with a company name of "Copy card - reject payment"
    When an agency user orders "1" registration card
    And I have my credit card payment rejected
    Then the payment is shown as rejected
