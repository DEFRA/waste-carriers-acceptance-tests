@bo_new @upper_tier @finance
Feature: Recording of a non worldpay renewal payment and negative conviction check marks the registration renewal as completed.
  As an administrator of the Waste Carriers service
  I need to be able to record payments and conviction check results
  So that renewals can be processed

  # Plan to build these into the registration_payments feature instead, to reduce reliance on seeded data:

  Scenario: Renewal paid for by bank transfer is marked as complete
      Given an Environment Agency user has signed in to the backend
        And registration "CBDU205" has an unsubmitted renewal
        And I cannot access payments until the bank transfer option is selected
        And the transient renewal's balance is 105

       When I search for "CBDU205" pending payment
        And I mark the renewal payment as received
       Then the expiry date should be three years from the previous expiry date
        And the registration's balance is 0

  Scenario: Renewal paid for by bank transfer but with a conviction flag is still pending conviction check sign off
      Given an Environment Agency user has signed in to the backend
        And registration "CBDU207" has an unsubmitted renewal
        And I cannot access payments until the bank transfer option is selected
        And the transient renewal's balance is 105

       When I search for "CBDU207" pending payment
        And I mark the renewal payment as received
       Then the registration has a status of "CONVICTIONS"
        And the registration's balance is 0
