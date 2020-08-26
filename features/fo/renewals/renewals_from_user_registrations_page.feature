@fo @fo_renew
Feature: Registered waste carrier chooses to renew their registration from registrations account page
  As a carrier of commercial waste
  I want to renew my waste carriers licence with the Environment Agency
  So I continue to be compliant with the law

  @smoke
  Scenario: Limited company renews upper tier registration from registrations list
    Given I create an upper tier registration for my "limitedCompany" business as "another-user@example.com"
    And I have signed in to renew my registration as "another-user@example.com"
    And I choose to renew my last registration from the dashboard
    When I complete my "limitedCompany" renewal steps
    Then I will be notified my renewal is complete
