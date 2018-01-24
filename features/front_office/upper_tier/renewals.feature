@frontoffice @upper_tier @renewal
Feature: Registered waste carrier chooses to renew their registration from registrations
  As a carrier of commercial waste
  I want to renew my waste carriers licence with the Environment Agency
  So I continue to be compliant with the law

  Scenario: Limited company renews upper tier registration from renewals page
  	Given I have signed in to renew my registration
  	  And I have chosen registration "CBDU1" ready for renewal
  	 When I complete my limited company renewal steps
  	 Then I will be notified that my registration has been renewed

  Scenario: Limited company changes business type and is informed to create a new registration
  	  Given I have signed in to renew my registration
  	  And I have chosen registration "CBDU2" ready for renewal
  	  But I change the business type to "localAuthority"
  	  Then I will be notified "You cannot renew"

   Scenario: Sole trader changes business type to based overseas
    Given I have signed in to renew my registration
      And I have chosen registration "CBDU3" ready for renewal
      But I change the business type to "overseas"
     Then I will be able to continue my renewal

  Scenario: Sole trader renews upper tier registration from renewals page
      Given I have signed in to renew my registration
      And I have chosen registration "CBDU6" ready for renewal
     When I complete my sole trader renewal steps
     Then I will be notified that my registration has been renewed

  Scenario: Local authority renews upper tier registration from renewals page
      Given I have signed in to renew my registration
      And I have chosen registration "CBDU7" ready for renewal
     When I complete my local authority renewal steps
     Then I will be notified that my registration has been renewed

  Scenario: Limited liability partnership renews upper tier registration from renewals page
    Given I have signed in to renew my registration
      And I have chosen registration "CBDU8" ready for renewal
     When I complete my limited liability partnership renewal steps
     Then I will be notified that my registration has been renewed

  Scenario: Other registration type renews upper tier registration from renewals page
    Given I have signed in to renew my registration
      And I have chosen registration "CBDU9" ready for renewal
     When I confirm my business type
     Then I will be notified "You should not renew"

  Scenario: Partnership renews upper tier registration from renewals page
    Given I have signed in to renew my registration
      And I have chosen registration "CBDU10" ready for renewal
     When I complete my partnership renewal steps
     Then I will be notified that my registration has been renewed

  Scenario: Overseas company renews upper tier registration from renewals page
    Given I have signed in to renew my registration
      And I have chosen registration "CBDU11" ready for renewal
     When I complete my overseas company renewal steps
     Then I will be notified that my registration has been renewed

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
