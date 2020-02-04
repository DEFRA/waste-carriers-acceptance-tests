@fo_new @upper_tier @fo_renewal @renewal
Feature: Registered waste carrier pays for their renewal
  As a carrier of commercial waste
  I want to be able to pay the relevant charge for my renewal
  So that my renewal is completed without any delay

    Scenario: Rejected worldpay payment can be paid for on another credit card
      Given I renew my registration using my previous registration number "CBDU218"
        And I have signed in to renew my registration as "user@example.com"
        And I am on the payment page
        But I have my credit card payment rejected
       When I can pay with another card
       Then I will be notified my renewal is complete

@email
    Scenario: Rejected worldpay payment can be paid for by bank transfer
      Given I renew my registration using my previous registration number "CBDU219"
        And I have signed in to renew my registration as "wcr-user@mailinator.com"
        And I am on the payment page
        But I have my credit card payment rejected
       When I can pay by bank transfer
       Then I will be notified my renewal is pending payment
        And I will receive a renewal appliction received email

# This test won't work if the mock is in place
@no_mock
    Scenario: Cancelled worldpay payment can be paid for by retrying card payment
      Given I renew my registration using my previous registration number "CBDU220"
        And I have signed in to renew my registration as "user@example.com"
        And I am on the payment page
        But I cancel my credit card payment
       When I try my credit card payment again
       Then I will be notified my renewal is complete
