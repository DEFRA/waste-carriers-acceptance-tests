Feature: Partnership applies for new upper tier registration
  As a carrier of commercial waste
  I want to register my partnership with the Environment Agency
  So I am compliant with the law

  Background:
    Given I start a new registration on the frontend
    When I complete my application of my partnership as a upper tier waste carrier

  Scenario: Partnership successfully registers for a upper tier waste carriers licence paying by credit card
    When I pay for my application by maestro ordering 2 copy cards
    Then I will be registered as an upper tier waste carrier
    And I receive a frontend email with text "we have registered you as an an upper tier"
    And the registration status will be "Registered"

  Scenario: Partnership successfully applies for an upper tier waste carriers licence choosing to pay by bank transfer
    When I choose to pay for my application by bank transfer ordering 0 copy cards
    Then I will be informed my registration is pending payment
    And my registration status will be "Awaiting payment"
