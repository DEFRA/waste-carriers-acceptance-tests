@frontoffice @upper_tier @ir_renewal
Feature: Public body applies for new upper tier registration
  As a carrier of commercial waste
  I want to renew my public body with the Environment Agency
  So I am compliant with the law
  
@broken
  Scenario: Public body renews expired registration from old waste carriers system
  	Given I renew my registration using my previous registration number "CB/VM8888WW/A001"
      And I complete the public body registration renewal
      And the registration details are found in the backoffice
     Then the registration has a "Registered" status
  	  And the registration status in the registration export is set to "ACTIVE"

  Scenario: Public body renews registration before registration expires
  Given I renew my registration using my previous registration number "CB/VM9999WW/A001"
    And I complete the public body registration renewal
   Then the registration has a "Registered" status
    And the registration status in the registration export is set to "ACTIVE"
    And the expiry date should be three years from the expiry date
