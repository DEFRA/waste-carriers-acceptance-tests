@bo_new @bo_dashboard

Feature: Cease and revoke registered waste carriers
As an agency user
I need to be able to deregister a registered waste carrier
So that they no longer have a valid waste carrier licence

Background:
	Given I sign into the back office as "agency-refund-payment-user"

  Scenario: Agency user can cease upper tier waste carrier licence
    Given I have an active registration
    When the registration is ceased
    Then the registration has a status of "INACTIVE"

  Scenario: Agency user can revoke upper tier waste carrier licence
    Given I have an active registration
    When the registration is revoked
    Then the registration has a status of "REVOKED"
