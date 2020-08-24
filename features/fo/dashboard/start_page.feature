@fo @fo_dashboard
Feature: Waste carrier navigates start page
  As a carrier of commercial waste
  I want to register in the appropriate country
  So that I'm compliant with the law

  Scenario: Navigate links on service start page
    Given I have reached the GOV.UK start page
    When I access the links on the page
    Then I can start my registration
