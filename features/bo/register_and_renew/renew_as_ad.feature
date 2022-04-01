@bo @bo_renew 
Feature: Assisted digital renewal of an upper tier public body
  As a carrier of commercial waste
  I want assistance with my waste carrier renewal from the Environment Agency
  So I can complete my regisration and I am compliant with the law
    
  Scenario: Limited company has their upper tier registration renewed by NCCC
    Given I have a new registration for a "limitedCompany" business
    And I sign into the back office as "agency-user"
    When I renew the limited company registration
    Then the AD renewal is complete
