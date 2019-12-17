@bo_new @upper_tier @bo_renew @renewal @wip

Feature: Incomplete renewal of an upper tier public body completed by NCCC
  As a carrier of commerical waste
  I want assistance with my waste carrier renewal from the Environment Agency
  So I can complete my regisration and I am compliant with the law

Scenario: Public body has their upper tier registration renewed by NCCC
  Given "CBDU229" has been partially renewed by the account holder
    And I have signed into the renewals service as an agency user
   When I complete the renewal "CBDU229" for the account holder
   Then the renewal is complete
