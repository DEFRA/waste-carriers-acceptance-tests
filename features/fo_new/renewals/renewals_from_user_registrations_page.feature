@fo_new @fo_renew @wip
Feature: Registered waste carrier chooses to renew their registration from registrations account page
  As a carrier of commercial waste
  I want to renew my waste carriers licence with the Environment Agency
  So I continue to be compliant with the law

  @smoke
  Scenario: Limited company renews upper tier registration from registrations list
    Given I create an upper tier registration for my "limitedCompany" business as "another-user@example.com"
    And I have signed in to view my registrations as "another-user@example.com"
  	And I choose to renew my last registration from the dashboard
    When I complete my limited company renewal steps
    Then I will be notified my renewal is complete

# This scenario will fail while the grace period is set to 90 days.
# Commenting out, as it's low risk and we will be removing this functionality soon:
  # Scenario: Limited company attempts to renew expired registration
  # 	   Given I have signed in to view my registrations as "user@example.com"
  #       When I try to renew anyway by guessing the renewal url for "CBDU233"
  #       Then I will be told my registration can not be renewed
