@bo @bo_reg @wip
Feature: NCCC agent unblocks a stuck registration from back office
  As an NCCC agent
  I want to unblock a registration using a back office function
  So that I can allow the customer to complete their application

  Background: Only run tests if mocking is enabled
  Given mocking is enabled
  
  Scenario: NCCC unblocks a stuck registration
    Given I register and get stuck at the payment stage
    And I sign into the back office as "agency-user"
    When I revert the current registration to payment summary
    Then I can submit the stuck user's application by bank transfer
@skip
  Scenario: Finance admin completes a missed WorldPay payment on a registration
    Given I register and get stuck at the payment stage
    And I sign into the back office as "finance-admin-user"
    When I add a missed Worldpay payment at the payment stage
    Then the registration has a status of "ACTIVE"
    And the registration does not have a status of "PAYMENT NEEDED"
    And the registration's balance is 0
    
  Scenario: NCCC unblocks a stuck renewal
    Given I create an upper tier registration for my "soleTrader" business as "user@example.com"
    And I receive an email from NCCC inviting me to renew
    And I start renewing my last registration from the email
    And I complete the renewal steps and get stuck at the payment stage
    When I sign into the back office as "agency-user"
    And I revert the current renewal to payment summary
    Then I can submit the stuck user's application by bank transfer
@skip
  Scenario: Finance admin completes a missed WorldPay payment on a renewal
    Given I create a new registration as "user@example.com"
    And I receive an email from NCCC inviting me to renew
    And I start renewing my last registration from the email
    And I complete the renewal steps and get stuck at the payment stage
    And I sign into the back office as "finance-admin-user"
    When I add a missed Worldpay payment at the payment stage
    Then the registration has a status of "ACTIVE"
    And the registration does not have a status of "PAYMENT NEEDED"
    And the registration's balance is 0
