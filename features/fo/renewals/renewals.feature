@fo_new @fo_renew
Feature: Registered waste carrier chooses to renew their registration from registration search
  As a carrier of commercial waste
  I want to renew my waste carriers licence with the Environment Agency
  So I continue to be compliant with the law

  @smoke
  Scenario: Limited company renews upper tier registration from renewals page
    Given I create an upper tier registration for my "limitedCompany" business as "user@example.com"
    And I renew my last registration
    And I have signed in to renew my registration as "user@example.com"
    When I complete my "limitedCompany" renewal steps
    Then I will be notified my renewal is complete

  Scenario: Charity renews registration from renewals page and is notified to register as lower tier
    Given I create a lower tier registration for my "charity" business as "user@example.com"
    When I renew my last registration
    Then I am told that my registration does not expire

  Scenario: Partnership renews upper tier registration from renewals page
    Given I create an upper tier registration for my "partnership" business as "user@example.com"
    And I renew my last registration
    And I have signed in to renew my registration as "user@example.com"
    When I complete my "partnership" renewal steps
    Then I will be notified my renewal is complete

  Scenario: Overseas renewal
    Given I create an upper tier registration for my "overseas" business as "user@example.com"
    And I renew my last registration
    And I have signed in to renew my registration as "user@example.com"
    When I complete my overseas company renewal steps
    Then I will be notified my renewal is complete

  Scenario: Limited liability partnership renews upper tier registration by bank transfer
    Given I create an upper tier registration for my "limitedLiabilityPartnership" business as "user@example.com"
    And I renew my last registration
    And I have signed in to renew my registration as "user@example.com"
    When I complete my limited liability partnership renewal steps choosing to pay by bank transfer
    Then I will be notified my renewal is pending payment
