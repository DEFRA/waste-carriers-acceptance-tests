@backoffice @wip
Feature: Permiting support advisor completes duly made check for application
  As a permiting support advisor
  I need to be able to check standard rules applications for completeness
  So that I can inform customers of anything missing they need to complete

  Background:
    Given I sign in as an authorised permiting support advisor
      And I have open standard rules application to check
      And I have a duly made checklist to complete

  Scenario: Permiting support advisor marks application as duly made
    When the standard rules application is set as duly made
    Then the standard rules application is now ready for its determination checks
     And the determination SLA clocks starts

  Scenario: Permiting support advisor requests more information from customer
    When the standard rules application check requests more information from the customer
    Then the applicant will be sent a request for information
     And the response SLA starts
