@frontoffice @upper_tier @ir_renewal
Feature: Renewals of waste carrier licence from previous Integrated Regulartions (IR) service
  As a carrier of commercial waste
  I want to renew my public body with the Environment Agency
  So I am compliant with the law
  

  Scenario: Public body renews expired registration from old waste carriers system
  	Given I renew my registration using my previous registration number "CB/VM8888WW/A001"
      But the registration is expired
     Then I will be told "The registration number you entered has expired"
      
@email
  Scenario: Public body renews registration before registration expires
  Given I renew my registration using my previous registration number "CB/VM8888WW/A002"
   When I complete the public body registration renewal
   Then the registration has a "Registered" status
    And the registration status in the registration export is set to "ACTIVE"
    And the expiry date should be three years from the expiry date
