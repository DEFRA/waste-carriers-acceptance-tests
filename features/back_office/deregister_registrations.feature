@backoffice
Feature: Deregister registered waste carriers
As an agency user
I need to be able to deregister a registered waste carrier
So that they no long have a valid waste carrier licence

Background: 
	Given an Environment Agency user has signed in

  Scenario: Agency user can deregister upper tier waste carrier licence
    Given a limited company "Upper tier deregister test" registers as an upper tier waste carrier
     When the registration is deregistered 
     Then the registration has a "De-Registered" status
      And the registration status in the registration export is set to "INACTIVE"