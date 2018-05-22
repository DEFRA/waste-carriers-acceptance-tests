@frontoffice @lower_tier @email @smoke 
Feature: New lower tier registrations
  As a carrier of domestic waste
  I want to register my company with the Environment Agency
  So I am compliant with the law

 Scenario: Charity successfully registers for a lower tier waste carriers licence
   Given I complete my application of my charity as a lower tier waste carrier
    When I confirm my email address
    Then I will be registered as a lower tier waste carrier
     And I have received an email "Waste Carrier Registration Complete" 
     And the registration status will be "Registered" 

 Scenario: Sole trader successfully registers for a lower tier waste carriers licence
   Given I complete my application of a sole trader business as a lower tier waste carrier
    When I confirm my email address
    Then I will be registered as a lower tier waste carrier
     And the registration status will be "Registered"
 
 Scenario: Public body successfully registers for a lower tier waste carriers licence
   Given I complete my application of my public body as a lower tier waste carrier
    When I confirm my email address
    Then I will be registered as a lower tier waste carrier
     And the registration status will be "Registered"
 
 Scenario: Partnership successfully registers for a lower tier waste carriers licence
   Given I complete my application of my partnership as a lower tier waste carrier
   	When I confirm my email address
    Then I will be registered as a lower tier waste carrier
     And the registration status will be "Registered"
 
 Scenario: Local authority successfully registers for a lower tier waste carriers licence
   Given I complete my application of my local authority as a lower tier waste carrier
   	When I confirm my email address
    Then I will be registered as a lower tier waste carrier
     And the registration status will be "Registered"
  
 Scenario: Limited company successfully registers for a lower tier waste carriers licence
   Given I complete my application of my limited company "LT Company limited" as a lower tier waste carrier
    When I confirm my email address
   	Then I will be registered as a lower tier waste carrier
    And the registration status will be "Registered"
 
 Scenario: Lower tier waste carrier does not confirm their email address
  Given I complete my application of my limited company "Unconfirmed company ltd" as a lower tier waste carrier
    But I do not confirm my email address
   Then my registration status for "Unconfirmed company ltd" will be "Pending"

     