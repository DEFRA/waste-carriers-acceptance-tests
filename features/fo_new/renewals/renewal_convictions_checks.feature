@fo_new @upper_tier @fo_renewal @renewal @convictions
Feature: Registered waste carrier declares conviction during renewal
  As a member of the waste carriers team in NCCC
  I want to be informed of any potential matches with the Environment Agencies convictions database
  So that I can then target my investigation of registration suitability to the right people

  @email
  Scenario: Limited company renews upper tier registration from renewals page declaring conviction
  	 Given I renew my registration using my previous registration number "CBDU212"
  	   And I have signed in to renew my registration as "wcr-user@mailinator.com"
      When I complete my limited company renewal steps declaring a conviction
  	  Then I will be notified my renewal is pending checks
       And I will receive a renewal appliction received email

   Scenario: Limited company renews upper tier registration from renewals page not declaring conviction
  	 Given I renew my registration using my previous registration number "CBDU221"
  	   And I have signed in to renew my registration as "user@example.com"
  	  When I complete my limited company renewal steps not declaring a conviction
  	  Then I will be notified my renewal is pending checks

   Scenario: Limited company renews upper tier registration from renewals page not declaring company conviction
  	 Given I renew my registration using my previous registration number "CBDU222"
  	   And I have signed in to renew my registration as "user@example.com"
  	  When I complete my limited company renewal steps not declaring a company conviction
  	  Then I will be notified my renewal is pending checks
