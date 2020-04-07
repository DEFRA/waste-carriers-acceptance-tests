@fo_new @lower_tier @fo_reg @wip
Feature: A new user registers as a lower tier waste carrier
  As a carrier of commercial waste
  I want to register for a lower tier licence
  So I can be compliant with the law

  Scenario: A charity registers as a lower tier waste carrier
    Given I want to register as a lower tier carrier
    When I start a new registration journey in "England" as a "charity"
      And I complete my registration
    Then I am notified that my registration has been successful

  Scenario: A sole trader registers as a lower tier waste carrier
    Given I want to register as a lower tier carrier
    When I start a new registration journey in "England" as a "soleTrader"
      And I complete my registration
    Then I am notified that my registration has been successful
