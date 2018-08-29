@backoffice @upper_tier @renewal

Feature: Assisted digital renewal of an upper tier public body
  As a carrier of commerical waste
  I want assistance with my waste carrier renewal from the Environment Agency
  So I can complete my regisration and I am compliant with the law

Background:
  Given an Environment Agency user has signed in to complete a renewal

Scenario: Public body has their upper tier registration renewed by NCCC
  Given I choose to renew "CBDU230"
    And I have signed into the renewals service
   When I renew the local authority registration
   Then my registration will have been renewed

Scenario: Limited company has their upper tier registration renewed by NCCC
  Given I choose to renew "CBDU231"
   When I renew the limited company registration
   Then my registration will have been renewed
