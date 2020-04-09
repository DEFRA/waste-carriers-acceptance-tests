@fo_new @lower_tier @fo_reg
Feature: A new user registers as an upper tier waste carrier
  As a carrier of commercial waste
  I want to register for an upper tier licence
  So I can be compliant with the law

  Scenario: A sole trader registers as a lower tier waste carrier and pays via Worldpay
    Given I want to register as an upper tier carrier
    When I start a new registration journey in "England" as a "soleTrader"
      And I complete my registration
      And I pay by card
    Then I am notified that my registration has been successful
