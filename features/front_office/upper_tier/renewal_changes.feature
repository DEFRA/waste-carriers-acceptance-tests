@frontoffice @upper_tier @renewal 
Feature: Registered waste carrier chooses to renew their registration from start page
  As a carrier of commercial waste
  I want to change my registration details when renew my waste carriers licence with the Environment Agency
  So my details are update date and I continue to be compliant with the law

    Scenario: On renewal a limited company changes its orgnanisation type to a sole trader prompting a new registration
    Given my limited company with companies house number "00445790" registers as an upper tier waste carrier
      And I confirm my email address
      And I choose to renew my registration using my previous registration number
      And I have signed into my account
     When I choose to renew my registration from my registrations list
      And the organisation type is changed to sole trader
     Then I'm informed I'll need to apply for a new registration
@wip
    Scenario: On renewal a partnership changes its registration type causing a £40 charge for the change
    Given I have registered my partnership as an upper tier waste carrier
      And I confirm my email address
      And I choose to renew my registration using my previous registration number
      And I have signed into my account
    When I choose to renew my registration from my registrations list
     And I change my registration type to "carrier_broker_dealer" and complete my renewal
    Then I'll be shown the "£105.00" renewal charge plus the "£40.00" charge for change

