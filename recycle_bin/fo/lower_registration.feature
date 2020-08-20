@fo_old @fo_reg
Feature: New lower tier registrations
  As a carrier of domestic waste
  I want to register my company with the Environment Agency
  So I am compliant with the law

  @email
  Scenario: Charity successfully registers for a lower tier waste carriers licence
    Given I complete my application of my charity as a lower tier waste carrier
    When I confirm my email address
    Then I will be registered as a lower tier waste carrier
    And I receive a frontend email with text "we have registered you as a lower tier waste carrier"
    And the registration status will be "Registered"

  @minismoke
  Scenario: Lower tier waste carrier does not confirm their email address
    Given I complete my application of my limited company "Unconfirmed company ltd" as a lower tier waste carrier
    But I do not confirm my email address
    Then my registration status for "Unconfirmed company ltd" will be "Pending"
