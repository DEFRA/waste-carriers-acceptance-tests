@backoffice @finance
Feature: Reversal of payment by finance administrator
As a NCCC user with refund permissions
I want to be able to refund payments
So that the customer can be refunded their application charge
 
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