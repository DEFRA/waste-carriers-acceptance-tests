@frontoffice @upper_tier @renewal @wip
Feature: Registered waste carrier declares conviction during renewal
  As a member of the waste carriers team in NCCC
  I want to be informed of any potential matches with the Environment Agencies convictions database
  So that I can then target my investigation of registration suitability to the right people

  Scenario: Limited company renews upper tier registration from renewals page declaring conviction
  	 Given I renew my registration using my previous registration number "CBDU22"
  	   And I have signed in to renew my registration
      When I complete my limited company renewal steps declaring a conviction
  	  Then I will be notified my renewal is pending checks