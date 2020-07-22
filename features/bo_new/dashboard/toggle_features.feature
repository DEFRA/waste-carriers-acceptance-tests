@bo_new @bo_dashboard

Feature: Toggle features
As an developer
I want to turn features off and on
So that I can help our contact centre manage demand

	Background:
		Given I sign into the back office as "developer"
		And I have a new registration for a "localAuthority" business

	Scenario: Turn features off and on again
	  When I turn all features off
	  Then the features are no longer available

		When I turn all features on
	  Then the features are available
