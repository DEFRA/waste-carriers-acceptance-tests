@frontoffice @upper_tier @renewal 
Feature: Registered waste carrier pays for their renewal
  As a carrier of commercial waste
  I want to be able to pay the relevant charge for my renewal
  So that my renewal is completed without any delay

    Scenario: Rejected worldpay payment can be paid for on another credit card
      Given I renew my registration using my previous registration number "CBDU28"
        And I have signed in to renew my registration
        And I am on the payment page
        But I have my credit card payment rejected
       When I can pay with another card
       Then I will be notified my renewal is complete
@payments
    Scenario: Rejected worldpay payment can be paid for by bank transfer
      Given I renew my registration using my previous registration number "CBDU29"
        And I have signed in to renew my registration
        And I am on the payment page
        But I have my credit card payment rejected
       When I can pay by bank transfer
       Then I will be notified my renewal is pending payment 
