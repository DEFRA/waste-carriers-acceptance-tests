@backoffice @finance
Feature: Refund (reverse) of application by finance administrator
As a finance administrator 
I want to be able to refund/reverse payments made in error
So that the customer can be refunded their application charge
@test
 Scenario: Refund of application charge from credit card payment
 Given I have an application paid by credit card
   And I am signed in as a finance admin
  When I refund the application payment
  Then the application payment will be refunded
   And the refund will be shown in the payment history
   And the outstanding balance will be the amount previously paid
 
 Scenario: Refund of application charge from credit card not possible by basic finance user
  Given I have a registration "CBDU112"
    And I am signed in as a finance user
   When I select the application to refund
   Then the refund option will not be available

Scenario: Refund of application charge from credit card not possible by NCCC user with other refund abilities
  Given I have a registration "CBDU112"
    And I am signed in as an Environment Agency user with refunds
   When I select the application to refund
   Then the refund option will not be available