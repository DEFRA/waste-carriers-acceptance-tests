@frontoffice @upper_tier
Feature: Upper tier registration edit charges
  As a carrier of commercial waste
  I want to be able to change my registration details
  So that my details are up to date and I'm compliant with the regulations

  Scenario: Limited company changing its carrier type incurs a charge
  Given I have registered my limited company as an upper tier "carrier_dealer"
   When I change my registration type to "carrier_broker_dealer"
   Then I will be charged "£40.00" for the change

  Scenario: Partnership adds new partner incurring new registration charge
  Given I have registered my partnership as an upper tier waste carrier
   When I add another partner to my registration
    And the charge "£154.00" has been paid
   Then its previous registration will be "De-Registered"
    And a new registration will be "Registered"

  Scenario: Partnership removes a partner incurring no charge
  Given I have registered my partnership as an upper tier waste carrier
   When I remove a partner from my registration
   Then I will not be charged for my change

  Scenario: Sole trader changes organsisation type incurring new registraiton charge
   Given I have registered my sole trading company as an uppper tier waste carrier
    When I change my organisation type to a limited company
     And the charge "£154.00" has been paid
    Then its previous registration will be "De-Registered"
     And a new registration will be "Registered"

  Scenario: Limited company changing its companies house number incurring new registration charge
  Given a limited company with companies house number "00445790" registers as an upper tier waste carrier
   When its companies house number changes to "SC171417"
    And the charge "£154.00" has been paid
   Then its previous registration will be "De-Registered"
    And a new registration will be "Registered"

Scenario: New registration is created for limited company changing its companies house number
  Given a limited company with companies house number "00445790" registers as an upper tier waste carrier
   When its companies house number changes to "SC171417"
    And the charge "£154.00" has been paid
   Then its previous registration will be "De-Registered"
    And a new registration will be "Registered"