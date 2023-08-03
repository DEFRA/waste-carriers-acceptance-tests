@bo @finance
Feature: Finance admin
  As a user with finance privilieges
  I want to administer finances for a registration
  So that the user and the EA have the correct amount of money

  This feature covers all main finance admin operations: refunds and charge adjustments (frequent)
  plus reversals and writeoffs (less frequent).
  
@refund @wipi
  Scenario: [RUBY-811] Successful refund of card payment for back office registration
    Given I sign into the back office as "agency-user"
    And I register an upper tier "partnership" from the back office
    And I pay by card
    And I am notified that my registration has been successful
    And the registration's balance is 0

    And NCCC makes a payment of 42 by "cheque"
    When an agency-refund-payment-user refunds the card payment
    Then the card payment is shown as refunded
    And the registration's balance is 0

  @refund
  Scenario: Successful refund of card payment for front office registration
    Given an upper tier "soleTrader" registration is completed in the front office
    And the registration's balance is 0
    When a finance admin user adjusts the charge by -5
    When an agency-refund-payment-user refunds the card payment
    Then the card payment is shown as refunded
    And the registration's balance is 0

  Scenario: [RUBY-870] Adjust charges on registration
    Given a registration with outstanding balance and 1 copy card has been submitted
    And NCCC makes a payment of 154 by "cash"
    And the registration has a status of "IN PROGRESS"
    And the registration's balance is 5
    When a finance admin user adjusts the charge by -5
    Then the registration has a status of "ACTIVE"
    And the registration does not have a status of "PAYMENT NEEDED"

  Scenario: [RUBY-809 & 810] Reverse and write off
    Given a registration with outstanding balance and 1 copy card has been submitted
    And NCCC makes a payment of 154 by "cash"
    And NCCC makes a payment of 3 by "cheque"
    And the registration's balance is 2
    When an "agency-refund-payment-user" reverses the previous payment
    Then the registration has a status of "IN PROGRESS"
    And the registration has a status of "PAYMENT NEEDED"

    Given the registration's balance is 5
    When an "agency-refund-payment-user" writes off the outstanding balance
    Then the registration's balance is 0
    And the registration has a status of "ACTIVE"
    And the registration does not have a status of "PAYMENT NEEDED"

    Given a finance admin user adjusts the charge by 6
    When a "finance-admin-user" writes off the outstanding balance
    Then the registration's balance is 0
    And the registration does not have a status of "PAYMENT NEEDED"
