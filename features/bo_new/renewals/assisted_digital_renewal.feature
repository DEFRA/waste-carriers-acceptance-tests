@bo_new @bo_renew @renewal @wip

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

# @broken
# This test fails because the grace period is currently set to 90 days and we haven't updated the seeding yet.
# Scenario: Expired registration in renewal grace window is only renewed after conviction check and payment is made
#   Given I choose to renew "CBDU232"
#     And I sign into the back office as "agency-refund-payment-user"
#     And I renew the limited company registration declaring a conviction and paying by bank transfer
#     And I search for "CBDU232" pending payment
#    When I mark the renewal payment as received
#     And I approve the conviction check
#    Then the expiry date should be three years from the previous expiry date
