@frontoffice @upper_tier
Feature: Sole trader applies for new upper tier registration
  As a carrier of commercial waste
  I want to register my sole trader business with the Environment Agency
  So I am compliant with the law
   
  Background:
   Given I start a new registration
   	When I complete my application of my sole trader business as a upper tier waste carrier 

  Scenario: Sole trader successfully registers for a upper tier waste carriers licence paying by credit card
    When I pay for my application by maestro ordering 2 copy cards
    Then I will be registered as an upper tier waste carrier
     And the registration status will be "Registered"

   Scenario: Sole trader successfully applies for an upper tier wasete carriers licence choosing to pay by bank transfer
    When I choose to pay for my application by bank transfer ordering 3 copy cards
    Then I will be informed my registration is pending payment
     And my registration status will be "Awaiting payment"

