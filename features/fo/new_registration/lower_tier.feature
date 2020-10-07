@fo @fo_reg @smoke
Feature: A new user registers as a lower tier waste carrier
  As a carrier of commercial waste
  I want to register for a lower tier licence
  So I can be compliant with the law

  Scenario: A charity registers as a lower tier waste carrier
    Given I want to register as a lower tier carrier
    When I start a new registration journey in "England" as a "charity"
    And I complete my registration for my business "Happy path LT Charity Registration"
    Then I am notified that my registration has been successful

@grace
  Scenario: A sole trader registers as a lower tier waste carrier
    Given I want to register as a lower tier carrier
    When I start a new registration journey in "England" as a "soleTrader"
    And I complete my registration for my business "Happy path LT Sole Trader Registration"
    Then I am notified that my registration has been successful
