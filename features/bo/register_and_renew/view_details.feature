@bo @bo_reg  
Feature: NCCC agent views registrations from back office
  As an NCCC agent
  I want to view registration and renewal details on one service
  So that I can quickly answer user queries

  Scenario: NCCC user creates registration and renewal, and checks status
    Given I have a new registration for a "partnership" with business name "Howdy pardner"
    When I check the registration details are correct on the back office
    Then the certificate shows the correct details

    Given there is an existing registration
    When NCCC partially renews an existing registration with "no convictions"
    Then the back office pages show the correct transient renewal details

    Given NCCC goes back to the in progress renewal
    When the applicant pays by bank card
    Then the renewal is complete
    And I check the registration details are correct on the back office
    And the certificate shows the correct details

  Scenario: NCCC user creates lower tier registration and checks certificate
    Given I have a new lower tier registration for a "publicBody" business
    When I check the registration details are correct on the back office
    Then the certificate shows the correct details
