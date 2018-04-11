@frontoffice @upper_tier @renewal
Feature: Registered waste carrier chooses to renew their registration from registrations
  As a carrier of commercial waste
  I want to renew my waste carriers licence with the Environment Agency
  So I continue to be compliant with the law

  Scenario: Limited company renews upper tier registration from renewals page
  	Given I have signed in to renew my registration
  	  And I have chosen registration "CBDU1" ready for renewal
  	 When I complete my limited company renewal steps
  	 Then I will be notified my renewal is complete
 
  Scenario: Sole trader renews upper tier registration from renewals page
      Given I have signed in to renew my registration
      And I have chosen registration "CBDU6" ready for renewal
     When I complete my sole trader renewal steps
     Then I will be notified my renewal is complete
 
  Scenario: Local authority renews upper tier registration from renewals page
      Given I have signed in to renew my registration
      And I have chosen registration "CBDU7" ready for renewal
     When I complete my local authority renewal steps
     Then I will be notified my renewal is complete
  
  Scenario: Limited liability partnership renews upper tier registration from renewals page
    Given I have signed in to renew my registration
      And I have chosen registration "CBDU8" ready for renewal
     When I complete my limited liability partnership renewal steps
     Then I will be notified my renewal is complete

  Scenario: Charity renews upper tier registration from renewals page and is notified to register as lower tier
    Given I have signed in to renew my registration
      And I have chosen registration "CBDU9" ready for renewal
     When I confirm my business type
     Then I will be notified "You should not renew"
  
  Scenario: Partnership renews upper tier registration from renewals page
    Given I have signed in to renew my registration
      And I have chosen registration "CBDU10" ready for renewal
     When I complete my partnership renewal steps
     Then I will be notified my renewal is complete
 
  Scenario: Overseas company renews upper tier registration from renewals page
    Given I have signed in to renew my registration
      And I have chosen registration "CBDU11" ready for renewal
     When I complete my overseas company renewal steps
     Then I will be notified my renewal is complete

  Scenario: Partnership renews upper tier registration but requires more than one partner to renew
    Given I have signed in to renew my registration
      And I have chosen registration "CBDU21" ready for renewal
     When I add two partners to my renewal
      But remove one partner and attempt to continue with my renewal
     Then I will be asked to add another partner

@expiry
    Scenario: Registration can not be renewed over one month before its expiry date
      Given I have an upper tier waste carrier licence
       When I renew my registration using my previous registration number "CBDU12"
        But the renewal date is over one month before it is due to expire
       Then I will be notified "You can not renew this registration yet"
@expiry
    Scenario: Registration can not be renewed on day of expiry
      Given I have an upper tier waste carrier licence
       When I renew my registration using my previous registration number "CBDU13"
        But the renewal date is today
       Then I will be notified "Registration expired"
