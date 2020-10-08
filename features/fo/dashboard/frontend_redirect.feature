@fo @fo_dashboard @smoke @minismoke
Feature: Old app redirects to new
  As a carrier of waste
  I want to access the service from a bookmark I have previously saved
  So I can register without disruption

  Scenario: Frontend redirects to front office
    Given the old apps are no longer available
    When an external user tries to access the old app
    Then the external user is redirected to the new app