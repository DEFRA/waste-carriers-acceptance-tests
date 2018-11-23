@frontoffice @upper_tier @renewal
Feature: Registered waste carrier chooses to renew their registration from registration search
  As a carrier of commercial waste
  I want to renew my waste carriers licence with the Environment Agency
  So I continue to be compliant with the law

@email
  Scenario: Sole trader renews upper tier registration from renewals page
    Given I renew my registration using my previous registration number "CBDU225"
      And I have signed in to renew my registration
     When I complete my sole trader renewal steps
     Then I will be notified my renewal is complete
      And I will receive a confirmation email of my renewal
 
  Scenario: Limited liability partnership renews upper tier registration from renewals page
    Given I renew my registration using my previous registration number "CBDU227"
      And I have signed in to renew my registration
     When I complete my limited liability partnership renewal steps
     Then I will be notified my renewal is complete

  Scenario: Charity renews upper tier registration from renewals page and is notified to register as lower tier
    Given I renew my registration using my previous registration number "CBDU228"
      And I have signed in to renew my registration
     When I confirm my business type
     Then I will be notified "You can register as a lower tier waste carrier"

  Scenario: Partnership renews upper tier registration from renewals page
    Given I renew my registration using my previous registration number "CBDU200"
      And I have signed in to renew my registration
     When I complete my partnership renewal steps
     Then I will be notified my renewal is complete

  Scenario: Overseas company renews upper tier registration from renewals page
    Given I renew my registration using my previous registration number "CBDU201"
      And I have signed in to renew my registration
     When I complete my overseas company renewal steps
     Then I will be notified my renewal is complete

  Scenario: Partnership renews upper tier registration but requires more than one partner to renew
    Given I renew my registration using my previous registration number "CBDU204"
      And I have signed in to renew my registration
     When I add two partners to my renewal
      But remove one partner and attempt to continue with my renewal
     Then I will be asked to add another partner

  Scenario: Limited liability partnership renews upper tier registration from renewals page
    Given I renew my registration using my previous registration number "CBDU214"
      And I have signed in to renew my registration
     When I complete my limited liability partnership renewal steps choosing to pay by bank transfer
     Then I will be notified my renewal is pending payment

@expiry
    Scenario: Registration can not be renewed over one month before its expiry date
    Given I renew my registration using my previous registration number "CBDU202"
      But the renewal date is over one month before it is due to expire
     Then I will be notified "This registration is not eligible for renewal"

@expiry
    Scenario: Registration can be renewed in expiry grace renewal window
      Given I renew my registration using my previous registration number "CBDU203"
        But the registration is within the expiry grace renewal window
       Then I will be prompted to sign in to complete the renewal
