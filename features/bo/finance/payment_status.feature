
@mocks
Feature: govPay payment and refund status updates

Scenario: Submitted govPay payment status informs the user of registration payment processing
    Given mocking is "enabled"
    And the govPay payment status is "submitted"
    And I sign into the back office as "agency-user"
    When I register an upper tier "partnership" from the back office
    And I pay by card
    Then I am notified that my registration is processing payment
    And the registration has a status of "in progress"
    And a registration received pending payment email will be sent

 Scenario: Submitted govPay payment status informs the user of renewal payment processing
    Given mocking is "enabled"
    And the govPay payment status is "submitted"
    When an upper tier "soleTrader" registration is completed in the front office
    Then I am notified that my registration is processing payment
    And the registration has a status of "in progress"
    And a registration received pending payment email will be sent

Scenario: Submitted refund status 
  Given mocking is "enabled"
    And the govPay refund status is "submitted"
    And an upper tier "soleTrader" registration is completed in the front office
    And the registration's balance is 0
   When a finance admin user adjusts the charge by -5
    And an agency-refund-payment-user refunds the card payment
    And the govPay refund status is "success"

Scenario: Upper tier registration with a pending card payment has payment status update to "success"
    Given mocking is "enabled"
    And I have a new upper tier registration with a pending card payment

    