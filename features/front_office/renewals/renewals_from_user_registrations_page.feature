@frontoffice @upper_tier @renewal 
Feature: Registered waste carrier chooses to renew their registration from registrations account page
  As a carrier of commercial waste
  I want to renew my waste carriers licence with the Environment Agency
  So I continue to be compliant with the law

  Scenario: Limited company renews upper tier registration from registrations list
       Given I have signed in to renew my registration as "another-user@example.com"
  	    When I choose registration "CBDU213" for renewal
  	    Then I will be shown the renewal start page

    Scenario: Limited company attempts to renew expired registration
  	   Given I have signed in to renew my registration as "user@example.com"
        When I try to renew anyway by guessing the renewal url for "CBDU203"
        Then I will be told my registration can not be renewed
