@frontoffice @upper_tier @renewal 
Feature: Registered waste carrier chooses to renew their registration from start page
  As a carrier of commercial waste
  I want to change my registration details when renew my waste carriers licence with the Environment Agency
  So my details are update date and I continue to be compliant with the law

    Scenario: On renewal a limited company changes its orgnaisation type to a sole trader prompting a new registration
    Given my limited company with companies house number "00445790" registers as an upper tier waste carrier
      And I confirm my email address
      And I choose to renew my registration using my previous registration number
      And I have signed into my account
     When I choose to renew my registration from my registrations list
      And the organisation type is changed to sole trader
     Then I'm informed I'll need to apply for a new registration