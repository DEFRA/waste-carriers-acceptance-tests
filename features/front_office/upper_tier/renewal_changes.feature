@frontoffice @upper_tier @renewal
Feature: Registered waste carrier chooses to renew their registration from start page
  As a carrier of commercial waste
  I want to change my registration details when I renew my waste carriers licence with the Environment Agency
  So my details are up to date and I continue to be compliant with the law

    Scenario: Limited company changes business type and is informed to create a new registration
      Given I have signed in to renew my registration
      And I have chosen registration "CBDU2" ready for renewal
      But I change the business type to "localAuthority"
      Then I will be notified "You cannot renew"
@wip
   Scenario: Sole trader changes business type to based overseas
    Given I have signed in to renew my registration
      And I have chosen registration "CBDU3" ready for renewal
      But I change the business type to "overseas"
     Then I will be able to continue my renewal

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

  Scenario: Partnership changes business type to Limited Liability Partnership
    Given I have signed in to renew my registration
      And I have chosen registration "CBDU14" ready for renewal
      But I change the business type to "limitedLiabilityPartnership"
     Then I will be able to continue my renewal

  Scenario: Limited company changes business type to Limited Liability Partnership
    Given I have signed in to renew my registration
      And I have chosen registration "CBDU15" ready for renewal
      But I change the business type to "limitedLiabilityPartnership"
     Then I will be able to continue my renewal




