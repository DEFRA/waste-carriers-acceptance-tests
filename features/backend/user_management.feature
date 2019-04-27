@backoffice
Feature: Manage backend users
  As an admin user
  I need to be able to add new and manage existing backend users
  So people can access the service

  Background:
    Given I sign in as an admin user

  Scenario: Admin user adds a new user
    When I create a new backend user
    Then the new backend user can sign in

  @data @wip
  Scenario: Admin user deletes a user
    When I delete a backend user
    Then the backend user cannot sign in
