@fo @fo_dashboard
Feature: Waste carrier navigates start page
  As a carrier of commercial waste
  I want to register in the appropriate country
  So that I'm compliant with the law

  Scenario: Register elsewhere in UK
    Given I am based outside England but in the UK
    When I check options for each country
    Then I can still decide to register in England