@bo 
Feature: Incomplete registrations and renewals completed by NCCC
  As a carrier of commercial waste
  I want assistance with my waste carrier registration from the Environment Agency
  So I am compliant with the law
  @bo_reg
  Scenario: NCCC resumes registration for an LLP
    Given I want to register as an upper tier carrier
    And I get part way through a front office registration
    And I sign into the back office as "agency-user"
    And the in-progress registration details are correct
    When I resume the registration as assisted digital
    Then the registration has a status of "ACTIVE"
    
  @bo_renew
  Scenario: NCCC resumes renewal for a public body
    Given I have a new registration for a "localAuthority" business
    And the registration has been partially renewed
    And I sign into the back office as "agency-user"
    When I complete the renewal for the account holder
    Then the renewal is complete
