@frontoffice @upper_tier @wip
Feature: Upper tier registration edits
  As a carrier of commercial waste
  I want to be able to change my registration details
  So that my details are up to date and I'm compliant with the regulations

  Scenario: Limited company changing its carrier type incurs a charge
  Given I have registered my limited company as an upper tier "carrier_dealer"
   When I change my registration type to "carrier_broker_dealer"
   Then I will be charged "£40" for the change