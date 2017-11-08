@frontoffice @upper_tier
Feature: Upper tier registration edit charges
  As a carrier of commercial waste
  I want to be able to change my registration details
  So that my details are up to date and I'm compliant with the regulations

  Scenario: Limited company changing its carrier type incurs a charge
  Given I have registered my limited company as an upper tier "carrier_dealer"
   When I change my registration type to "carrier_broker_dealer"
   Then I will be charged "£40.00" for the change
@wip
  Scenario: Partnership adds new partner incurring new registration charge
  Given I have registered my partnership as an upper tier waste carrier
   When I add another partner to my registration
   Then I will be charged "£154.00" for the change
