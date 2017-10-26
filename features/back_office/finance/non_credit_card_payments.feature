@backoffice @finance @wip
Feature: Recording of a non credit card registration by Environment Agency user
As an Environment Agency User
I want to be be able to enter non credit card payments 
So that the payment can be recorded and the registration completed

Scenario: Application pending payment has full payment recorded as received

 Given I have an application that is pending payment
   And I am signed in as an Environment Agency user with refunds
  When I enter a payment for the full amount owed
  Then the registration will be marked as complete
  
 