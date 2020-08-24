Feature: Waste carrier uncertain of business type
  As a carrier of commercial waste
  I want to know which category of business type I should register as
  So that I'm confident I've registered correctly

  Scenario: Waste carrier doesn't know what business type to register is
    Given I start a new registration
    When I select that I don't know what business type to enter
    Then I will be informed to contact the Environment Agency
