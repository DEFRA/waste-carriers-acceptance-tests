@fo @fo_renew
Feature: Registered waste carrier chooses to renew their registration from start page
  As a carrier of commercial waste
  I want to change my registration details when I renew my waste carriers licence with the Environment Agency
  So my details are up to date and I continue to be compliant with the law

  Scenario: Limited company changes business type and is informed to create a new registration
    Given I create an upper tier registration for my "limitedCompany" business
    And I start renewing this registration
    
    But I change the business type to "localAuthority"
    Then I will be notified "You need a new registration"
    And I have the option to start a new registration

  Scenario: Sole trader changes place of business location to outside the UK
    Given I create an upper tier registration for my "soleTrader" business
    And I start renewing this registration
    
    But I change my place of business location to "overseas"
    Then I will be able to continue my renewal

  Scenario: Sole trader changes place of business location to Scotland
    Given I create an upper tier registration for my "soleTrader" business
    And I start renewing this registration
    But I change my place of business location to "Scotland"
    Then I will be notified "You can register in Scotland"

  Scenario: On renewal a partnership changes its registration type causing a £48 charge for the change
    Given I create an upper tier registration for my "partnership" business
    And I start renewing this registration
    
    When I change my carrier broker dealer type to "carrier_broker_dealer"
    Then I will be notified "Because your carrier type has changed, there will also be a £48 charge"

  Scenario: Partnership changes business type to Limited Liability Partnership
    Given I create an upper tier registration for my "partnership" business
    And I start renewing this registration
    
    But I change the business type to "limitedLiabilityPartnership"
    Then I will be notified "You need a new registration"

  Scenario: Limited company confirms company information is incorrect and is informed to create a new registration
    Given I create an upper tier registration for my "limitedCompany" business
    And I start renewing this registration
    
    But I do not confirm my company details are correct
    Then I will be notified "If you have a new companies house number you need to create a new registration"
