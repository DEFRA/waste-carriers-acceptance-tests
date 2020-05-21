@fo_new @fo_renewal
Feature: Registered waste carrier declares conviction during renewal
  As a member of the waste carriers team in NCCC
  I want to be informed of any potential matches with the Environment Agency's convictions database
  So that I can then target my investigation of registration suitability to the right people

  @email
  Scenario: Limited company renews upper tier registration from renewals page declaring conviction
  	Given I create a new registration as "wcr-user@mailinator.com"
      And I renew my last registration
  	  And I have signed in to renew my registration as "wcr-user@mailinator.com"
    When I complete my limited company renewal steps declaring a conviction
  	Then I will be notified my renewal is pending checks
      And I will receive a renewal application received email

  Scenario: Limited company renews upper tier registration from renewals page not declaring conviction
  	Given I create a new registration as "user@example.com"
      And I renew my last registration
  	  And I have signed in to renew my registration as "user@example.com"
  	When I complete my limited company renewal steps not declaring a conviction
  	Then I will be notified my renewal is pending checks

  Scenario: Limited company renews upper tier registration from renewals page not declaring company conviction
  	Given I create a new registration as "user@example.com" with a company name of "Waste Not Want Not, UK"
      And I renew my last registration
      And I have signed in to renew my registration as "user@example.com"
  	When I complete my limited company renewal steps not declaring a company conviction
  	Then I will be notified my renewal is pending checks
