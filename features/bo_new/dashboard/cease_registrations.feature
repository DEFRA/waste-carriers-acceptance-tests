@bo_old @bo_dashboard
# WARNING: This will only work once, locally, between database resets and vagrant reloads

Feature: Cease registered waste carriers
As an agency user
I need to be able to deregister a registered waste carrier
So that they no longer have a valid waste carrier licence

Background:
	Given an Environment Agency user has signed in to the back office

  Scenario: Agency user can cease upper tier waste carrier licence
    Given I have a registration "CBDU106"
     When the registration is ceased
     # Then the registration has a "De-Registered" status
 		 Then the registration has a status of "INACTIVE"
