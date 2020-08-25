@bo @finance
Feature: Recording of a non worldpay renewal payment and negative conviction check marks the registration renewal as completed.
  As an administrator of the Waste Carriers service
  I need to be able to record payments and conviction check results
  So that renewals can be processed

  Scenario: Renewal paid for by bank transfer is marked as complete
    Given I have an active registration
    And the registration has an unsubmitted renewal
    And I cannot access payments until the bank transfer option is selected
    And the transient renewal's balance is 105
    When I search for the renewal pending payment
    And I mark the renewal payment as received
    Then the expiry date should be three years from the previous expiry date
    And the registration's balance is 0

@wip
  Scenario: Renewal paid for by bank transfer but with a conviction flag is still pending conviction check sign off
    Given I have an active registration with a company number of "01649776"
    And the registration has an unsubmitted renewal
    And I cannot access payments until the bank transfer option is selected
    And the transient renewal's balance is 105
    When I search for the renewal pending payment
    And I mark the renewal payment as received
    Then the registration has a status of "CONVICTIONS"

    When I approve the conviction check for the renewal
    Then the registration has a status of "ACTIVE"
    And the registration does not have a status of "CONVICTIONS"
