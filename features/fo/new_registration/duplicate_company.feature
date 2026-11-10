Feature: Duplicate company registration

  Scenario: Duplicate company can not register again
    Given I want to register as an upper tier carrier
    And I enter a companies house number that is already registered
    Then I will be told that a registration already exists for this company
   