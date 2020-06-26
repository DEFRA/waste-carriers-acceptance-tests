@fo_new @fo_renew
Feature: Registered waste carrier pays for their renewal
  As a carrier of commercial waste
  I want to be able to pay the relevant charge for my renewal
  So that my renewal is completed without any delay

  # These steps are built to be bypassed when mocking is in place.

    Scenario: Rejected worldpay payment can be paid for on another credit card
      Given mocking is disabled
        And I create a new registration as "user@example.com"
        And I renew my last registration
        And I have signed in to renew my registration as "user@example.com"
        And I am on the payment page
        But I have my credit card payment rejected
       When I can pay with another card
       Then I will be notified my renewal is complete

@email
    Scenario: Rejected worldpay payment can be paid for by bank transfer
      Given I create a new registration as "wcr-user@example.com"
        And I renew my last registration
        And I have signed in to renew my registration as "wcr-user@example.com"
        And I am on the payment page
        But I have my credit card payment rejected
       When I can pay by bank transfer
       Then I will be notified my renewal is pending payment
        And I will receive an email with text "You need to pay for your waste carriers registration"

    Scenario: Cancelled worldpay payment can be paid for by retrying card payment
      Given mocking is disabled
        And I create a new registration as "user@example.com"
        And I renew my last registration
        And I have signed in to renew my registration as "user@example.com"
        And I am on the payment page
        But I cancel my credit card payment
       When I try my credit card payment again
       Then I will be notified my renewal is complete
