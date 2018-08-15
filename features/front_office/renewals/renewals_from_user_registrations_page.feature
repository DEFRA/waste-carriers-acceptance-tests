@frontoffice @upper_tier @renewal 
Feature: Registered waste carrier chooses to renew their registration from registrations account page
  As a carrier of commercial waste
  I want to renew my waste carriers licence with the Environment Agency
  So I continue to be compliant with the law
@todo
  Scenario: Limited company renews upper tier registration from registrations list
       Given I have signed in to renew my registration as "another-user@example.com"
  	     And I choose registration "CBDU213" for renewal
        When I complete my limited company renewal steps
         And view my registration on the dashboard
        Then I will see my registration has been renewed
  	   

    Scenario: Limited company attempts to renew expired registration
  	   Given I have signed in to renew my registration as "user@example.com"
        When I try to renew anyway by guessing the renewal url for "CBDU203"
        Then I will be told my registration can not be renewed
