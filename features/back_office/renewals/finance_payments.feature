@backoffice @upper_tier @renewal 
Feature: Recording of a non worldpay renewal payment and negative conviction check marks the registration renewal as completed.
  As an administrator of the Waste Carriers service
  I need to be able to record payments and conviction check results
  So that renewals can be processed

  Scenario: Renewal paid for by bank transfer is marked as complete
      Given an Environment Agency user has signed in to complete a renewal
        And registration "CBDU205" has a renewal paid by bank transfer
       When I search for "CBDU205"
        And mark the renewal payment as received
       Then the expiry date should be three years from the previous expiry date

  Scenario: Renewal paid for by bank transfer but with a conviction flag is still pending conviction check sign off
      Given an Environment Agency user has signed in to complete a renewal
        And registration "CBDU207" has a renewal paid by bank transfer
       When I search for "CBDU207"
        And mark the renewal payment as received
       Then the registration will have a "PENDING CONVICTIONS" status



