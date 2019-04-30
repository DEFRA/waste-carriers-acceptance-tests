@backend
Feature: Backend user completes assisted digital registration for a user
  As an agency user
  I need to register a waste carrier
  So that I can register carriers on behalf of assisted digital users

  Scenario: Registration of a charity by a backend user
    Given I sign in as an agency user
     When I complete a charity registration
     Then I will be informed the registration is complete
