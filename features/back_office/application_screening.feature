@backoffice @wip
Feature: Permiting support advisor screens application
  As a permiting support advisor
  I need to be able to screen the location of the application
  So that I can check if there any restrictions for a permit in that area

  Background:
    Given I sign in as an authorised permiting support advisor
      And I close the explore dynamics message
      And I have an open application to screen

  Scenario: Permiting support advisor approves application screening
    When I mark the appliation screening as successful
    Then the application will be ready for its duly made check

  Scenario: Permiting support advisor marks application screening for a consultation
    When I mark the application screening as requiring a consulation
    Then the application will be assigned to a permitting advisor

  Scenario: Permiting support advisor refuses application screening
    When I mark the appliation screening as unsuccessful
    Then the application will be returned
