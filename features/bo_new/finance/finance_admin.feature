@bo_new @upper_tier @finance

Feature: Finance admin
  As a user with finance privilieges
  I want to administer finances for a registration
  So that the user and the EA have the correct amount of money

  This feature covers all main finance admin operations: refunds and charge adjustments (frequent)
  plus reversals and writeoffs (less frequent).

  Background:
      Given an Environment Agency user has signed in to the backend
        And NCCC partially registers an upper tier "broker_dealer" "soleTrader" with "no convictions"

@smoke
  Scenario: [RUBY-811] Refund WorldPay payments on registration and renewal
      Given the applicant pays by bank card
        And NCCC finishes the registration

      Given the registration's balance is 0
        And NCCC makes a payment of 42 by "cheque"
       When an agency-refund-payment-user refunds the WorldPay payment
       Then the WorldPay payment is shown as refunded
        And the registration's balance is 0

      Given NCCC partially renews an existing registration with "no convictions"
        And the applicant pays by bank card
        And the registration's balance is 0

      Given NCCC makes a payment of 99 by "cheque"
       When an agency-refund-payment-user refunds the WorldPay payment
       Then the WorldPay payment is shown as refunded
        And the registration's balance is 0

@smoke
  Scenario: [RUBY-870] Adjust charges on registration and renewal
      Given the applicant chooses to pay for the registration by bank transfer ordering 1 copy card
        And NCCC makes a payment of 154 by "cash"
        And the registration has a status of "IN PROGRESS"

      Given the registration's balance is 5
       When a finance admin user adjusts the charge by -5
        And the registration has a status of "ACTIVE"
        And the registration does not have a status of "PAYMENT NEEDED"

      Given the registration's balance is 0
       When a finance admin user adjusts the charge by 10
       Then the registration's balance is 10
        And the registration has a status of "PAYMENT NEEDED"
        And NCCC makes a payment of 10 by "cash"

      Given NCCC partially renews an existing registration with "no convictions"
        And the applicant chooses to pay for the renewal by bank transfer ordering 2 copy cards
        And NCCC makes a payment of 105 by "cash"
        And the transient renewal's balance is 10
       When a finance admin user adjusts the charge by -15
       Then the registration's balance is -5
        And the registration has a status of "ACTIVE"

@smoke
  Scenario: [RUBY-809 & 810] Reverse and write off
      Given the applicant chooses to pay for the registration by bank transfer ordering 1 copy card
        And NCCC makes a payment of 154 by "cash"
        And NCCC makes a payment of 3 by "cheque"

      Given the registration's balance is 2
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
