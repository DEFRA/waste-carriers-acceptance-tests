@backoffice @upper_tier @renewal @wip
Feature: Assisted digital renewal of an upper tier public body
  As a carrier of commerical waste
  I want assistance with my waste carrier renewal from the Environment Agency
  So I can complete my regisration and I am compliant with the law

Scenario: Public body has their upper tier registration renewed by NCCC
Given I have my public body upper tier registration completed for me
 When I have my public body upper tier renewal completed for me
  And I pay for my application over the phone by maestro ordering 1 copy card
 Then my registration will have been renewed
