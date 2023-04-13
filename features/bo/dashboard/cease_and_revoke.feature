@bo @bo_dashboard
Feature: Cease and revoke and restore registrations

  As an agency user
  I need to be able to deregister a registered waste carrier
  So that they no longer have a valid waste carrier registration

  Background:
    Given I sign into the back office as "agency-refund-payment-user"

  Scenario: Agency user can cease upper tier waste carrier registration
    Given I have an active registration
    When the registration is ceased
    Then the registration has a status of "INACTIVE"

  Scenario: Agency user can revoke upper tier waste carrier registration
    Given I have an active registration
    When the registration is revoked
    Then the registration has a status of "REVOKED"

  Scenario: Revoked upper tier past its expiry date can not be restored
   Given I have a revoked expired registration
    Then I should not be able to restore the registration

  Scenario: Revoked uppper tier registration can be restored
   Given I have a revoked upper tier registration
    When the registration is restored
    Then the registration has a status of "ACTIVE"

  Scenario: Ceased lower tier registration can be restored
   Given I have a ceased lower tier registration
    When the registration is restored
    Then the registration has a status of "ACTIVE"