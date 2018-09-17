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
@ts
 Scenario: Worldpay payment for registration refunded by agency user with refunds
  Given I have an application paid by credit card
    And I am signed in as a finance admin
    And I add a negative charge of £154 to the registration
   When I am signed in as an Environment Agency user with refunds
    And I refund the worldpay payment
   Then the refund will be completed successfully
    And the balance is paid in full
  


