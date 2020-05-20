# TBD
Feature: NCCC agent cancel in progress registration from back office
  As an NCCC agent
  I want to cancel an in-progress registration
  So that we can correctly regulate the waste activity

Background:
  Given I sign into the back office as "agency-refund-payment-user"

Scenario: NCCC cancel a registration pending payment
  Given a registration with outstanding balance and 0 copy cards has been submitted
  When I cancel the registration
  Then the registration has a status of "INACTIVE"

Scenario: NCCC cancel a registration pending conviction checks
  Given a registration with outstanding convictions checks has been submitted
  When I cancel the registration
  Then the registration has a status of "INACTIVE"

Scenario: NCCC select cancel and then decides to keep the registration
  Given a registration with outstanding balance and 0 copy cards has been submitted
  When I am about to cancel the registration and change my mind
  Then the registration does not have a status of "INACTIVE"
