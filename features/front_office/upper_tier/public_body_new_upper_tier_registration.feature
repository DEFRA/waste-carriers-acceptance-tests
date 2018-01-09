@frontoffice @upper_tier
Feature: Public body applies for new upper tier registration
  As a carrier of commercial waste
  I want to register my public body with the Environment Agency
  So I am compliant with the law
  
  Background:
   Given I start a new registration
   	When I complete my application of my public body as an upper tier waste carrier 

  Scenario: Public body successfully registers for a upper tier waste carriers licence paying by credit card
    When I pay for my application by maestro ordering 1 copy card
   	Then I will be registered as an upper tier waste carrier
    And the registration status will be "Registered"

   Scenario: Public body successfully applies for an upper tier waste carriers licence choosing to pay by bank transfer
    When I choose to pay for my application by bank transfer ordering 7 copy cards
    Then I will be informed my registration is pending payment 
     And my registration status will be "Awaiting payment"