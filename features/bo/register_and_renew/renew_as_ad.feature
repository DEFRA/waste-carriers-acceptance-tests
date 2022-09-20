@bo @bo_renew 
Feature: Assisted digital renewal of an upper tier public body
  As a carrier of commercial waste
  I want assistance with my waste carrier renewal from the Environment Agency
  So I can complete my regisration and I am compliant with the law

  @letter
  Scenario: Upper tier registration renewed by NCCC with no contact email receives a confirmation letter
    Given I have a new registration for a "limitedCompany" business
    But the user has no contact email address
    And I sign into the back office as "agency-user"
    When I renew the limited company registration
    Then the renewal is complete
    And a renewal confirmation letter is sent
