@fo_new @fo_reg @smoke @minismoke
Feature: A new user registers as an upper tier waste carrier
  As a carrier of commercial waste
  I want to register for an upper tier licence
  So I can be compliant with the law

  Background:
    Given I want to register as an upper tier carrier

  Scenario: A sole trader registers as an upper tier waste carrier and pays via Worldpay
    When I start a new registration journey in "England" as a "soleTrader"
    And I complete my registration for my business "Happy Path UT Registration"
    And I pay by card
    Then I am notified that my registration has been successful

  Scenario: A partnership registers as an upper tier waste carrier with pending Worldpay payment
    Given mocking is enabled
    When I start a new registration journey in "England" as a "soleTrader"
    And I complete my registration for my business "UT Registration Pending WorldPay"
    And I pay by card
    Then I am notified that my registration payment is being processed
