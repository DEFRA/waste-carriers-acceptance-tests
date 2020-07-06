@fo_new @fo_renew
Feature: Registered waste carrier chooses to renew their registration from registration search
  As a carrier of commercial waste
  I want to renew my waste carriers licence with the Environment Agency
  So I continue to be compliant with the law

  @smoke
  Scenario: Limited liability partnership renews upper tier registration from renewals page
    Given I create an upper tier registration for my "limitedLiabilityPartnership" business as "user@example.com"
      And I renew my last registration
      And I have signed in to renew my registration as "user@example.com"
     When I complete my "limitedLiabilityPartnership" renewal steps
     Then I will be notified my renewal is complete

    Scenario: Charity renews registration from renewals page and is notified to register as lower tier
      Given I create a lower tier registration for my "charity" business as "user@example.com"
        And I renew my last registration
       Then I am told that my registration does not expire

  Scenario: Partnership renews upper tier registration from renewals page
    Given I create an upper tier registration for my "partnership" business as "user@example.com"
      And I renew my last registration
      And I have signed in to renew my registration as "user@example.com"
     When I complete my "partnership" renewal steps
     Then I will be notified my renewal is complete

  # TODO: This is using a CBDU201 which is actually a partnership.
  # Fix this by generating an overseas registration and fix the steps in "I complete my overseas company renewal steps"
  # Scenario: Overseas company renews upper tier registration from renewals page
  #   Given I renew my registration using my previous registration number "CBDU201"
  #     And I have signed in to renew my registration as "user@example.com"
  #    When I complete my overseas company renewal steps
  #    Then I will be notified my renewal is complete

# Combine this with partner scenario above
  Scenario: Partnership renews upper tier registration but requires more than one partner to renew
    Given I create an upper tier registration for my "partnership" business as "user@example.com"
      And I renew my last registration
      And I have signed in to renew my registration as "user@example.com"
     When I add two partners to my renewal
      But remove one partner and attempt to continue with my renewal
     Then I will be asked to add another partner

  Scenario: Limited liability partnership renews upper tier registration from renewals page
    Given I create an upper tier registration for my "limitedLiabilityPartnership" business as "user@example.com"
      And I renew my last registration
      And I have signed in to renew my registration as "user@example.com"
     When I complete my limited liability partnership renewal steps choosing to pay by bank transfer
     Then I will be notified my renewal is pending payment
