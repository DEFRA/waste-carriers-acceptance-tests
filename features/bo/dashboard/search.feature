@search
Feature: Search for registrations using search criteria

Scenario: Registration can be found by searching for full name
    Given I create an upper tier registration for my "partnership" business
      And I sign into the back office as "data_user"
     When I search for the name "Robert Smith"
     Then I can see the search results have been found

Scenario: Data agent can search for a postcode in a registration
    Given I sign into the back office as "data_user"
     When I search for "BS1 5AH"
     Then I can see the search results have been found

Scenario: Registration can be found by searching for an email address
    Given I create an upper tier registration for my "partnership" business
      And I sign into the back office as "data_user"
     When I search for email "user@example.com"
     Then I can see the search results have been found

Scenario: Registration can be found by searching for its registration number
    Given I create an upper tier registration for my "partnership" business
      And I sign into the back office as "data_user"
     When I search using the registration number
     Then I can see the search results have been found