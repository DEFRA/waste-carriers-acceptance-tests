@frontoffice @upper_tier @renewal @payments
Feature: Registered waste carrier pays for their renewal
  As a carrier of commercial waste
  I want to be able to pay the relevant charge for my renewal
  So that my renewal is completed without any delay

    Scenario: Rejected worldpay payment can be paid for on another credit card
      Given I renew my registration using my previous registration number "CBDU26"
        And I have signed in to renew my registration
