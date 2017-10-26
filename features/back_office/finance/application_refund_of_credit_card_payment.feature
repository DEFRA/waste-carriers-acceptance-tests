@backoffice @finance @wip
Feature: Refund of application by finance administrator
As a finance administrator 
I want to be be able to refund payments made in error
So that the customer can be refunded their application charge

Background:
Given I have an application paid by credit card
  And I am signed in as a finance admin
  

Scenario: Refund of application charge from credit card payment

 When I refund the application payment
 Then the application payment will be refunded