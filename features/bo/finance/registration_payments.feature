@bo @finance
Feature: [RUBY-826] Pay for registrations
  As a user with finance privilieges
  I want to help a user pay for a registration
  So that their registration can be activated

  Background:
    Given a registration with outstanding balance and 1 copy cards has been submitted
    And I sign into the back office as "agency-user"
    And the registration's balance is 159

  @smoke
  Scenario: Pay for registration, partly by cash, complete by cheque
    When NCCC makes a payment of 100 by "cash"
    Then the registration has a status of "IN PROGRESS"
    And the registration has a status of "PAYMENT NEEDED"
    And the registration's balance is 59

    When NCCC pays the remaining balance by "cheque"
    Then the registration has a status of "ACTIVE"
    And the registration does not have a status of "PAYMENT NEEDED"
    And I check the registration details are correct on the back office
    And the registration's balance is 0

  Scenario: Pay for registration, partly by bank transfer, complete by Worldpay
    When NCCC makes a payment of 100 by "transfer"
    Then the registration has a status of "IN PROGRESS"
    And the registration has a status of "PAYMENT NEEDED"
    And the registration's balance is 59

    When NCCC pays the remaining balance by "missed_worldpay"
    Then the registration has a status of "ACTIVE"
    And the registration does not have a status of "PAYMENT NEEDED"
    And I check the registration details are correct on the back office
    And the registration's balance is 0
