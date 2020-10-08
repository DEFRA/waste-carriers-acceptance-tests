@fo @fo_renew
Feature: Registered waste carrier chooses to renew their registration from start page
  As a carrier of commercial waste
  I want to change my registration details when I renew my waste carriers licence with the Environment Agency
  So my details are up to date and I continue to be compliant with the law

  Scenario: Limited company changes business type and is informed to create a new registration
    Given I create an upper tier registration for my "limitedCompany" business as "user@example.com"
    And I start renewing this registration from the start page
    And I have signed in to renew my registration as "user@example.com"
    But I change the business type to "localAuthority"
    Then I will be notified "You need a new registration"
    And the button allows me to start a new registration

  Scenario: Sole trader changes place of business location to outside the UK
    Given I create an upper tier registration for my "soleTrader" business as "user@example.com"
    And I start renewing this registration from the start page
    And I have signed in to renew my registration as "user@example.com"
    But I change my place of business location to "overseas"
    Then I will be able to continue my renewal

  Scenario: Sole trader changes place of business location to Scotland
    Given I create an upper tier registration for my "soleTrader" business as "user@example.com"
    And I start renewing this registration from the start page
    And I have signed in to renew my registration as "user@example.com"
    But I change my place of business location to "scotland"
    Then I will be notified "You can register in Scotland"

  Scenario: On renewal a partnership changes its registration type causing a £40 charge for the change
    Given I create an upper tier registration for my "partnership" business as "user@example.com"
    And I start renewing this registration from the start page
    And I have signed in to renew my registration as "user@example.com"
    When I change my carrier broker dealer type to "carrier_broker_dealer"
    Then I will be notified "Because your carrier type has changed, there will also be a £40 charge"

  Scenario: On renewal a sole trader answers questions that direct to lower tier
    Given I create an upper tier registration for my "soleTrader" business as "user@example.com"
    And I start renewing this registration from the start page
    And I have signed in to renew my registration as "user@example.com"
    When I answer questions indicating I should be a lower tier waste carrier
    Then I will be notified "You can register as a lower tier waste carrier"
    And the button allows me to start a new registration

  Scenario: Partnership changes business type to Limited Liability Partnership
    Given I create an upper tier registration for my "partnership" business as "user@example.com"
    And I start renewing this registration from the start page
    And I have signed in to renew my registration as "user@example.com"
    But I change the business type to "limitedLiabilityPartnership"
    Then I will be able to continue my renewal

  Scenario: Limited company changes companies house number and is informed to create a new registration
    Given I create an upper tier registration for my "limitedCompany" business as "user@example.com"
    And I start renewing this registration from the start page
    And I have signed in to renew my registration as "user@example.com"
    But I change my companies house number to "10926928"
    Then I will be notified "You cannot renew"
