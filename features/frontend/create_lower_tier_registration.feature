@frontend @wip
Feature: Registering as a lower tier waste carrier
  As a carrier of waste
  I want to register my company with the Environment Agency
  So I am compliant with the law

  @smoke
  Scenario: Registration by a charity
    Given I am a charity
     When I register
     Then I will be informed the registration is complete
