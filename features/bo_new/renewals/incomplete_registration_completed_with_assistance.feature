@bo_new @bo_renew @renewal @wip

Feature: Incomplete renewal of an upper tier public body completed by NCCC
  As a carrier of commerical waste
  I want assistance with my waste carrier renewal from the Environment Agency
  So I can complete my regisration and I am compliant with the law

Scenario: Public body has their upper tier registration renewed by NCCC
  Given I have a new registration for a "localAuthority" business
    And the registration has been partially renewed by the account holder
    And I sign into the back office as "agency-user"
   When I complete the renewal for the account holder
   Then the renewal is complete
