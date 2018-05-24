@frontoffice @upper_tier @renewal
Feature: Registered waste carrier chooses to renew their registration from registrations account page
  As a carrier of commercial waste
  I want to renew my waste carriers licence with the Environment Agency
  So I continue to be compliant with the law

  Scenario: Limited company renews upper tier registration from registrations list
       Given I have signed in to renew my registration as "another-user@waste-exemplar.gov.uk"
  	    When I choose registration "CBDU23" for renewal
  	    Then I will be shown the renewal start page
@todo
    Scenario: Limited company attempts to renew expired regisgration
  	   Given I have signed in to renew my registration as "user@waste-exemplar.gov.uk"
  	    When I choose registration "CBDU13" for renewal
  	    Then I will be told my registration can not be renewed

