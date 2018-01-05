@backoffice @finance
Feature: Refund of application by finance administrator
As a finance administrator 
I want to be be able to refund payments made in error
So that the customer can be refunded their application charge

Background:
Given I have an application paid by credit card

 Scenario: Refund of application charge from credit card payment
 Given I am signed in as a finance admin
 When I refund the application payment
 Then the application payment will be refunded
 And the refund will be shown in the payment history
 And the outstanding balance will be the amount previously paid
 
 Scenario: Refund of application charge from credit card not possible by basic finance user
  Given I am signed in as a finance user
   When I select the application to refund
   Then the refund option will not be available