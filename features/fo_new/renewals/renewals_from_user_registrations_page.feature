@fo_new @upper_tier @fo_renewal @renewal @fo_dashboard
Feature: Registered waste carrier chooses to renew their registration from registrations account page
  As a carrier of commercial waste
  I want to renew my waste carriers licence with the Environment Agency
  So I continue to be compliant with the law

  @smoke
  Scenario: Limited company renews upper tier registration from registrations list
       Given I have signed in to view my registrations as "another-user@example.com"
  	     And I choose registration "CBDU213" for renewal
        When I complete my limited company renewal steps
         And view my registration on the dashboard
        Then I will see my registration "CBDU213" has been renewed

# This scenario will fail while the grace period is set to 90 days.
# Commenting out, as it's low risk and we will be removing this functionality soon:
  # Scenario: Limited company attempts to renew expired registration
  # 	   Given I have signed in to view my registrations as "user@example.com"
  #       When I try to renew anyway by guessing the renewal url for "CBDU233"
  #       Then I will be told my registration can not be renewed
