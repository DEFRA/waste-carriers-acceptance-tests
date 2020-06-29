@bo_new @bo_dashboard
Feature: NCCC agent unblocks a registration from back office
  As an NCCC agent
  I want to unblock a registration using a back office function
  So that I can allow the customer to complete their application

  Scenario: NCCC unblocks a stuck registration
    Given I register and get stuck at the payment stage
    When I sign into the back office as "agency-user"
    And I revert the current registration to payment summary
    Then I can submit the stuck user's application by bank transfer

  Scenario: NCCC unblocks a stuck renewal
    Given I create a new registration as "user@example.com" with a company name of "Stuck renewal test"
    And I receive an email from NCCC inviting me to renew
    And I start renewing my last registration from the email
    And I complete the renewal steps and get stuck at the payment stage

    When I sign into the back office as "agency-user"
    And I revert the current renewal to payment summary
    Then I can submit the stuck user's application by bank transfer
