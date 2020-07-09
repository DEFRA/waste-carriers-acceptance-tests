@bo_new @bo_reg

Feature: Assisted digital renewal of an upper tier public body
  As a carrier of commercial waste
  I want assistance with my waste carrier renewal from the Environment Agency
  So I can complete my regisration and I am compliant with the law

Background:
  Given an Environment Agency user has signed in to the backend

Scenario: Public body has their upper tier registration renewed by NCCC
  Given I have a new registration for a "localAuthority" business
    And I sign into the back office as "agency-user"
   When I renew the local authority registration
   Then the renewal is complete

Scenario: Limited company has their upper tier registration renewed by NCCC
  Given I have a new registration for a "limitedCompany" business
    And I sign into the back office as "agency-user"
   When I renew the limited company registration
   Then the renewal is complete
