@bo @bo_reg
Feature: Assisted digital lower tier registrations
  As a carrier of commercial waste
  I want assistance with my waste carrier registration from the Environment Agency
  So I can complete my regisration and I am compliant with the law

  Scenario: Lower tier charity is registered from back office
    Given I sign into the back office as "agency-user"
    When I register an lower tier "charity" from the back office
    Then I am notified that my registration has been successful
    And the registration has a status of "ACTIVE"
    And a registraton confirmation email will be sent