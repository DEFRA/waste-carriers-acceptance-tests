@fo @fo_renew @email
Feature: Registered waste carrier pays for their renewal
  As a carrier of commercial waste
  I want to be able to pay the relevant charge for my renewal
  So that my renewal is completed without any delay

  Scenario: Rejected card payment can be paid for by bank transfer
    Given mocking is "disabled"
    And I create a new registration with a company name of "Rejected payment renewal test"
    And I receive an email from NCCC inviting me to renew
    And I start renewing my last registration from the email
    And I complete my renewal up to the payment page
    And I have my credit card payment rejected
    When I pay by bank transfer
    Then I will be notified my renewal is pending payment
    And I will receive a registration renewal pending payment email

  Scenario: Cancelled card payment can be paid for by retrying card payment
    Given mocking is "disabled"
    And I create a new registration with a company name of "Cancelled payment renewal test"
    And I receive an email from NCCC inviting me to renew
    And I start renewing my last registration from the email
    And I complete my renewal up to the payment page
    And I cancel my credit card payment
    When I pay by bank transfer
    Then I will be notified my renewal is pending payment
    And I will receive a registration renewal pending payment email
