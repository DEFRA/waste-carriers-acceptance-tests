@fo_old @fo_reg
Feature: Limited company applies for new upper tier registration
  As a carrier of commercial waste
  I want to register my company with the Environment Agency
  So I am compliant with the law

  Background:
  Given I start a new registration
   When I complete my application of my limited company as an upper tier waste carrier

  @smoke @minismoke
  Scenario: Limited company successfully registers for an upper tier waste carriers licence paying by credit card
   When I pay for my application by maestro ordering 5 copy cards
   Then I will be registered as an upper tier waste carrier
    And the registration status will be "Registered"

 @email
  Scenario: Limited company successfully applies for an upper tier waste carriers licence choosing to pay by bank transfer
   When I choose to pay for my application by bank transfer ordering 2 copy cards
   Then I will be informed my registration is pending payment
    And I have received an application received email
    And my registration status will be "Awaiting payment"
