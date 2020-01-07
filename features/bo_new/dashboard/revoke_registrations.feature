@bo_old @bo_dashboard
Feature: Revoke registered waste carriers
As an agency user
I need to be able to revoke a registered waste carrier
So that they no longer have a valid waste carrier licence

Background:
	Given an Environment Agency user has signed in to the back office

  Scenario: Agency user can revoke upper tier waste carrier licence
    Given I have a registration "CBDU111"
     When the registration is revoked
     # Then the registration has a "Revoked" status
		 Then the registration has a status of "REVOKED"

		Given an Environment Agency user has signed in to the backend
		 Then the registration status in the registration export is set to "REVOKED"
