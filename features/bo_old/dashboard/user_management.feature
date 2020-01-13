@bo_old @bo_dashboard
Feature: User management feature
As a super user
I need to copy the users I have created in the backend into the back office
So that these users can then use the renewals service

  Scenario: Creating a agency user in the backend and then migrating the user account to have access to the back office
    Given an Agency super user has signed in to the admin area
      And has created an agency user for "test@example.com"
     When I sign into the back office as "agency_super"
      And migrates the backend users to the back office
     Then the user has been added to the back office
