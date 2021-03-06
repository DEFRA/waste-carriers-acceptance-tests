This feature will be obsolete when back office finance admin goes live.
Equivalent features have been written in back office.

Feature: Recording of a non credit card registration by Environment Agency user
As an Environment Agency User
I want to be be able to enter non credit card payments
So that the payment can be recorded and the registration completed

Scenario: Application pending payment has full payment recorded as received
 Given I am signed in as an Environment Agency user with refunds
   And I have a registration "CBDU107"
  When I enter a cash payment for the full amount owed
  Then the registration will be marked as "Registered"
   And I have received an registration complete email

 Scenario: Application pending payment has overpayment recorded
  Given I have a registration "CBDU108"
    And I am signed in as an Environment Agency user with refunds
   When I enter a cheque payment overpaying for the amount owed
   Then the registration will be marked as "Registered"
    And the payment status will be marked as overpaid

 Scenario: Application pending payment has underpayment recorded
  Given I have a registration "CBDU109"
    And I am signed in as an Environment Agency user with refunds
   When I enter a postal order payment underpaying for the amount owed
   Then the registration will be marked as "Awaiting payment"
    And the payment status will be marked as underpaid

 Scenario: Application pending payment has bank transfer recorded
   Given I have a registration "CBDU110"
     And I am signed in as a finance user
    When I enter a bank transfer payment for the full amount owed
    Then the registration will be marked as "Registered"
