@backoffice
Feature: New application
  As a permiting support advisor
  I need to be able to create standard rules applications for users over the phone
  So that I can support them with their permit application

  Background:
    Given I sign in as an authorised permiting support advisor
      And I see the P&SC dashboard
      And I close the explore dynamics message if present

  Scenario: Permiting support advisor creates a new permit application
     When I create a new standard rules application
     Then I am shown the new application details form

  @wip
  Scenario: Permiting support advisor completes application for customer
     When I create a new standard rules application
     And  I enter the customers details
     Then I will be shown the screening activities form
