@fo_new @fo_renew @email
Feature: Registered waste carrier pays for their renewal
  As a carrier of commercial waste
  I want to be able to pay the relevant charge for my renewal
  So that my renewal is completed without any delay

  Scenario: Rejected worldpay payment can be paid for by bank transfer
    Given I create a new registration as "user@example.com" with a company name of "Rejected payment renewal test"
    And I receive an email from NCCC inviting me to renew
    And I start renewing my last registration from the email
    And I complete my renewal up to the payment page
    And I have my credit card payment rejected
    When I pay by bank transfer
    Then I will be notified my renewal is pending payment
    And I will receive an email with text "You need to pay for your waste carriers registration"

  Scenario: Cancelled worldpay payment can be paid for by retrying card payment
    Given I create a new registration as "user@example.com" with a company name of "Cancelled payment renewal test"
    And I receive an email from NCCC inviting me to renew
    And I start renewing my last registration from the email
    And I complete my renewal up to the payment page
    And I cancel my credit card payment
    When I pay by bank transfer
    Then I will be notified my renewal is pending payment
    And I will receive an email with text "You need to pay for your waste carriers registration"

  Scenario: Complete renewal with pending Worldpay payment
    Given mocking is enabled
    And I create a new registration as "user@example.com" with a company name of "Pending payment renewal test"
    And I receive an email from NCCC inviting me to renew
    When I renew from the email as a "limitedCompany"
    Then I am notified that my renewal payment is being processed
