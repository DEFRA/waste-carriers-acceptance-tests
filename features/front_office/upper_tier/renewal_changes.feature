@frontoffice @upper_tier @renewal @wip
Feature: Registered waste carrier chooses to renew their registration from start page
  As a carrier of commercial waste
  I want to change my registration details when I renew my waste carriers licence with the Environment Agency
  So my details are up to date and I continue to be compliant with the law

    Scenario: On renewal a partnership changes its registration type causing a £40 charge for the change
    Given I have signed in to renew my registration
      And I have chosen registration "CBDU4" ready for renewal
     When I change my carrier broker dealer type to "carrier_broker_dealer"
     Then I will be notified "Because your carrier type has changed, there will also be a £40 charge"

    Scenario: On renewal a sole trader answers questions that direct to lower tier
    Given I have signed in to renew my registration
      And I have chosen registration "CBDU5" ready for renewal
     When I answer questions indicating I should be a lower tier waste carrier
     Then I will be informed I should not renew my upper tier waste carrier registration


