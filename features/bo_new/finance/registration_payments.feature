@bo_new @upper_tier @finance

Feature: [RUBY-826] Pay for registrations
  As a user with finance privilieges
  I want to help a user pay for a registration
  So that their registration can be activated

  Background:
      Given an Environment Agency user has signed in to the backend
        And NCCC partially registers an upper tier "broker_dealer" "soleTrader" with "no convictions"
        And the applicant chooses to pay for the registration by bank transfer ordering 1 copy card
        And I sign into the back office as "agency-user"
        And the registration's balance is 159

  Scenario: Pay for registration, partly by cash, complete by cheque
       When NCCC makes a payment of 100 by "cash"
       Then the registration has a status of "IN PROGRESS"
        And the registration has a status of "PAYMENT NEEDED"
        And the registration's balance is 59

       When NCCC pays the remaining balance by "cheque"
       Then the registration has a status of "ACTIVE"
        And the registration does not have a status of "PAYMENT NEEDED"
        And the back office pages show the correct registration details
        And the registration's balance is 0

  Scenario: Pay for registration, partly by bank transfer, complete by Worldpay
       When NCCC makes a payment of 100 by "transfer"
       Then the registration has a status of "IN PROGRESS"
        And the registration has a status of "PAYMENT NEEDED"
        And the registration's balance is 59

       When NCCC pays the remaining balance by "missed_worldpay"
       Then the registration has a status of "ACTIVE"
        And the registration does not have a status of "PAYMENT NEEDED"
        And the back office pages show the correct registration details
        And the registration's balance is 0
  
