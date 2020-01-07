@bo_new @upper_tier @bo_renew @renewal

Feature: Assisted digital renewal of an upper tier public body
  As a carrier of commerical waste
  I want assistance with my waste carrier renewal from the Environment Agency
  So I can complete my regisration and I am compliant with the law

Background:
  Given an Environment Agency user has signed in to the back office

Scenario: Public body has their upper tier registration renewed by NCCC
  Given I choose to renew "CBDU230"
    And I have signed into back office as an agency user
   When I renew the local authority registration
   Then the renewal is complete

Scenario: Limited company has their upper tier registration renewed by NCCC
  Given I choose to renew "CBDU231"
    And I have signed into back office as an agency user
   When I renew the limited company registration
   Then the renewal is complete

Scenario: Expired registration in renewal grace window is only renewed after conviction check and payment is made
  Given I choose to renew "CBDU232"
    And I have signed into back office as an agency user
    And I renew the limited company registration declaring a conviction and paying by bank transfer
    And I search for "CBDU232" pending payment
   When I mark the renewal payment as received
    And I approve the conviction check
   Then the expiry date should be three years from the previous expiry date
