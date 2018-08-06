@backoffice @upper_tier @renewal @wip

Feature: Assisted digital renewal of an upper tier public body
  As a carrier of commerical waste
  I want assistance with my waste carrier renewal from the Environment Agency
  So I can complete my regisration and I am compliant with the law

Scenario: Public body has their upper tier registration renewed by NCCC
Given I have signed into the renewals service
  And I choose to renew "CBDU216"
 When I renew the public body registration
 Then my registration will have been renewed
