@bo_new @bo_dashboard @wip
Feature: [RUBY-759] Manage users
  As a super user
  I want to amend EA user privileges
  So that the right people can help our users

Scenario: Agency super user adds an agency user then upgrades them
  Given I sign into the back office as "agency-super"
  When I invite a new "agency" user
  Then the new user has the correct back office permissions
  When the new user accepts their invitation and sets up a password
  Then the new user is logged in
  When I sign into the back office as "agency-super"
  And I update the new user role to an "agency with refund"
  Then the new user has the correct back office permissions

Scenario: Agency super user adds and removes an agency user
  Given I sign into the back office as "agency-super"
    And I invite a new "agency" user
    And the new user accepts their invitation and sets up a password
  When I sign into the back office as "agency-super"
    And I deactivate the new user
  Then the new user cannot log in to the back office

Scenario: Finance super adds a finance user
  Given I sign into the back office as "finance-super"
  When I invite a new "finance" user
  Then the new user has the correct back office permissions

Scenario: Agency super users cannot manage finance users
  Given I sign into the back office as "agency-super"
  When I access the user management screen
  Then I cannot manage finance users

Scenario: Finance super users cannot manage agency users
  Given I sign into the back office as "finance-super"
  When I access the user management screen
  Then I cannot manage agency users
