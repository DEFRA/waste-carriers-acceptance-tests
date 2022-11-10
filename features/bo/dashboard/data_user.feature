@bo @bo_dashboard @prod
Feature: Data agent
  As a data agent
  I want to view registration details
  So that I can look into the registration's history

  Scenario: Data agent can search for a postcode in a registration
    Given I sign into the back office as "data_user"
    When I search for "BS1 5AH"
    Then I can see registrations in the search results
