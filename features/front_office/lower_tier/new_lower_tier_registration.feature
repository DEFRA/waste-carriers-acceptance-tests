@frontoffice @lower_tier
Feature: New lower tier registrations
  As a carrier of domestic waste
  I want to register my company with the Environment Agency
  So I am compliant with the law
   
 Scenario: Charity successfully registers for a lower tier waste carriers licence
   Given I start a new registration
   	When I complete my registration of my charity as a lower tier waste carrier
   	Then I will be asked to confirm my email address

 Scenario: Sole trader successfully registers for a lower tier waste carriers licence
   Given I start a new registration
   	When I complete my registration of a sole trader business as a lower tier waste carrier
   	Then I will be asked to confirm my email address

 Scenario: Public body successfully registers for a lower tier waste carriers licence
   Given I start a new registration
   	When I complete my registration of my public body as a lower tier waste carrier
   	Then I will be asked to confirm my email address

 Scenario: Partnership successfully registers for a lower tier waste carriers licence
   Given I start a new registration
   	When I complete my registration of my partnership as a lower tier waste carrier
   	Then I will be asked to confirm my email address

 Scenario: Local authority successfully registers for a lower tier waste carriers licence
   Given I start a new registration
   	When I complete my registration of my local authority as a lower tier waste carrier
   	Then I will be asked to confirm my email address
@wip
 Scenario: Limited company successfully registers for a lower tier waste carriers licence
   Given I have completed my application of my limited company as a lower tier waste carrier
    When I confirm my email address
   	Then I will be registered as a lower tier waste carrier
     And I will have received a registration complete confirmation email 

 Scenario: Lower tier limited company applies for a lower tier waste carriers licence
   Given I start a new registration
    When I complete my application of my limited company as a lower tier waste carrier
    Then I will be asked to confirm my email address
     