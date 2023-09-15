@fo @fo_renew
Feature: Registered waste carrier chooses to renew their registration from registration search
  As a carrier of commercial waste
  I want to renew my waste carriers licence with the Environment Agency
  So I continue to be compliant with the law

  @smoke @email
  Scenario: Limited company renews upper tier registration from renewals page
    Given I create an upper tier registration for my "limitedCompany" business as "user@example.com"
    And I start renewing this registration
    When I complete my "limitedCompany" renewal steps
    Then I will be notified my renewal is complete
    And I will receive a registration renewal confirmation email
  
  Scenario: Partnership renews upper tier registration from renewals page
    Given I create an upper tier registration for my "partnership" business as "user@example.com"
    And I start renewing this registration
    
    When I complete my "partnership" renewal steps
    Then I will be notified my renewal is complete
    And I will receive a registration renewal confirmation email

  @email
  Scenario: Overseas renewal
    Given I create an upper tier registration for my "overseas" business as "user@example.com"
    And I start renewing this registration
    
    When I complete my overseas company renewal steps
    Then I will be notified my renewal is complete
    And I will receive a registration renewal confirmation email

  @email
  Scenario: Limited liability partnership renews upper tier registration by bank transfer
    Given I create an upper tier registration for my "limitedLiabilityPartnership" business as "user@example.com"
    And I start renewing this registration
    
    When I complete my limited liability partnership renewal steps choosing to pay by bank transfer
    Then I will be notified my renewal is pending payment
    And I will receive a registration renewal pending payment email
