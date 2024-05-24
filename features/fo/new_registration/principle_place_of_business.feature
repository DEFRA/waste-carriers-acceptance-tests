Feature: Principle place of business

  @email
  Scenario: A company from Northern Ireland can register to carry, broker or deal waste in England
    Given I want to register as an upper tier carrier
    When I start a new registration journey in "Northern Ireland" as a "soleTrader"
    And I complete my registration for my business "Happy Path UT Registration"
    And I pay by card
    Then I am notified that my registration has been successful
    And I will receive a registration confirmation email
    And the registration certificate can be viewed from the email
 
  Scenario: A company from Wales can not register to carry, broker or deal waste in England
    Given I want to register as an upper tier carrier
    But my princple place of business is in "Wales"
    Then I will be informed "You must register in Wales"

  Scenario: A company from Scotland can not register to carry, broker or deal waste in England
    Given I want to register as an upper tier carrier
    But my princple place of business is in "Scotland"
    Then I will be informed "You must register in Scotland"