@bo_new @upper_tier @bo_dashboard @wip
Feature: [RUBY-759] Manage users
  As a super user
  I want to amend EA user privileges
  So that the right people can help our users

Scenario: Agency super user adds an agency user then upgrades them
 Given I sign into the back office as "agency-super" # this step already exists
  When I invite a new "agency-user" # new step required. Store @user_email and @user_type as a variable to reuse across steps.
  Then the new user has the correct back office permissions # just do a small spot check on the permissions, as there's a full test in permissions.feature

  When I update the "agency-user" to an "agency-refund-payment-user" # new step
  Then the new user has the correct back office permissions # reuse above step with different variable

Scenario: Agency super user adds and removes an agency user
 Given I sign into the back office as "agency-super"
   And I invite a new "agency-user" # Reuse previous test with different parameter
  When I remove the new user # new step
  Then the new user cannot log in to the back office # new step

Scenario: Finance super adds a finance user
 Given I sign into the back office as "finance-super" # this step already exists
  When I invite a new "finance-user" # reuse above step with parameter
  Then the new user has the correct back office permissions # just do a small spot check on the permissions, as there's a full permissions test in permissions.feature

Scenario: Agency super users cannot manage finance users
 Given I sign into the back office as "agency-super"
  When I access the user management screen # new step
  Then I cannot manage finance users # new step

Scenario: Finance super users cannot manage agency users
 Given I sign into the back office as "finance-super"
  When I access the user management screen # reuse from above
  Then I cannot manage agency users # new step
