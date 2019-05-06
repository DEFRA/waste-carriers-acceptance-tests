@frontend
Feature: Registering as an upper tier waste carrier
  As a carrier of waste
  I want to register my company with the Environment Agency
  So I am compliant with the law

  @wip
  Scenario: Registration by an individual
    Given I am an individual
     When I register
     Then I will be informed the registration is complete
