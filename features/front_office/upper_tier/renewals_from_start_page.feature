@frontoffice @upper_tier @renewal @wip
Feature: Registered waste carrier chooses to renew their registration from start page
  As a carrier of commercial waste
  I want to renew my waste carriers licence with the Environment Agency
  So I continue to be compliant with the law

  Scenario: Sole trader renews
  	Given I have registered my sole trading company as an uppper tier waste carrier
  	 When I choose to renew my registration using my previous registration number
  	  And I have signed into my account
  	 Then I will be shown the renewal introduction page
