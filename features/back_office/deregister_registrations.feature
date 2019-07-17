@backoffice
# WARNING: This will only work once, locally, between database resets and vagrant reloads

Feature: Deregister registered waste carriers
As an agency user
I need to be able to deregister a registered waste carrier
So that they no longer have a valid waste carrier licence

Background:
	Given an Environment Agency user has signed in

  Scenario: Agency user can deregister upper tier waste carrier licence
    Given I have a registration "CBDU106"
     When the registration is deregistered
     Then the registration has a "De-Registered" status
