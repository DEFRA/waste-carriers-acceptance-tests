@frontoffice @upper_tier @renewal
Feature: Registered waste carrier chooses to renew their registration from registrations
  As a carrier of commercial waste
  I want to renew my waste carriers licence with the Environment Agency
  So I continue to be compliant with the law

  @wip
  Scenario: Limited company renews upper tier registration from renewals page
  	Given I have signed in to renew my registration
  	  And I have chosen registration "CBDU1" ready for renewal
  	 When I complete my limited company renewal steps
  	 Then I will be notified that my registration has been renewed

  Scenario: Limited company changes business type and informed to create new registration
  	  Given I have signed in to renew my registration
  	  And I have chosen registration "CBDU2" ready for renewal
  	  But I change the business type to "localAuthority"
  	  Then I will be notified that I'm unable to continue my renewal
  	 