@bo @bo_reg
Feature: NCCC agent cancels in progress registration from back office
  As an NCCC agent
  I want to cancel an in-progress registration
  So that we can correctly regulate the waste activity

  Background:
    Given I sign into the back office as "agency-refund-payment-user"

  Scenario: NCCC cancels a registration pending bank transfer
    Given a registration with outstanding balance and 0 copy cards has been submitted
    When I cancel the registration
    Then the registration has a status of "INACTIVE"

  Scenario: NCCC cancels a registration pending conviction checks
    Given a registration with outstanding convictions checks has been submitted
    When I cancel the registration
    Then the registration has a status of "INACTIVE"
