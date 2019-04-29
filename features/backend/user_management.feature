@backoffice
Feature: Manage backend users
  As an admin user
  I need to be able to add new and manage existing backend users
  So people can access the service

  Scenario: Agency super user adds a new user
    Given I sign in as an agency super user
     When I create a new backend user
     Then the new backend user can sign in

  @data
  Scenario: Agency super user edits a user
    Given I sign in as an agency super user
     When I edit a backend user
     Then the edited backend user can sign in

  @data
  Scenario: Agency super user deletes a user
    Given I sign in as an agency super user
     When I delete a backend user
     Then the backend user cannot sign in

  Scenario: Finance super user adds a new user
    Given I sign in as a finance super user
     When I create a new finance backend user
     Then the new backend user can sign in
