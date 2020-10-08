@bo @bo_dashboard @smoke @minismoke
Feature: Old app redirects to new
  As an Environment Agency user
  I want to access the service from a bookmark I have previously saved
  So I can continue helping users

  Scenario: Backend redirects to back office
    Given the old apps are no longer available
    When an Environment Agency user tries to access the previous URLs
    Then the Environment Agency user cannot access the old URLs