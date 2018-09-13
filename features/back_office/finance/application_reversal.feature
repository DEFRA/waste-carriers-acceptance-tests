@backoffice @finance
Feature: Reversal of payment by finance administrator
As a finance administrator 
I want to be able to reverse payments made in error
So that payments made in error can be reversed.

@test
 Scenario: Reversal of application charge from credit card payment
 Given I have an application paid by credit card
   And I am signed in as a finance admin
  When I reverse the application payment
  Then the application payment will be reversed
   And the reversal will be shown in the payment history
   And the outstanding balance will be the amount previously paid
 