@frontoffice @upper_tier @renewal 
Feature: Registered waste carrier chooses to renew their registration from start page
  As a carrier of commercial waste
  I want to renew my waste carriers licence with the Environment Agency
  So I continue to be compliant with the law

  Scenario: Sole trader renews upper tier registration from start page
  	Given I have registered my sole trading company as an uppper tier waste carrier
  	 When I choose to renew my registration using my previous registration number
  	  And I have signed into my account
  	 Then I will be shown the renewal information page

  Scenario: Partnership renews upper tier registration from waste carrier registrations page
  	Given I have registered my partnership as an upper tier waste carrier
  	  And I have signed into my account
  	 When I choose to renew my registration from my registrations list
  	 Then I will be shown the renewal information page

  Scenario: Lower tier registration attempts to renew their registration and is informed it's not necessary
    Given I choose to renew my registration
     When I enter my lower tier registration number "CBDL1"
     Then I'm informed "lower tier registrations do not expire and therefore don't require renewal"

  Scenario: On renewal a limited company changes its orgnaisation type to a sole trader
    Given my limited company with companies house number "00445790" registers as an upper tier waste carrier
      And I confirm my email address
      And I choose to renew my registration using my previous registration number
      And I have signed into my account
     When I choose to renew my registration from my registrations list
      And the organisation type is changed to sole trader
     Then I'm informed I'll need to apply for a new registration

