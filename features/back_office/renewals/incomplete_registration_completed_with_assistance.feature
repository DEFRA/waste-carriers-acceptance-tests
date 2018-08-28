@backoffice @upper_tier @renewal

Feature: Assisted digital renewal of an upper tier public body
  As a carrier of commerical waste
  I want assistance with my waste carrier renewal from the Environment Agency
  So I can complete my regisration and I am compliant with the law

Scenario: Public body has their upper tier registration renewed by NCCC
  Given "CBDU122" has been partially renewed by the account holder
    And I have signed into the renewals service
   When I complete the renewal "CBDU122" for the account holder
   Then the registration will have been renewed