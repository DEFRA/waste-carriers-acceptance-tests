@frontoffice @lower_tier @email
Feature: New lower tier registrations
  As a carrier of domestic waste
  I want to register my company with the Environment Agency
  So I am compliant with the law

 Scenario: Charity successfully registers for a lower tier waste carriers licence
   Given I complete my application of my charity as a lower tier waste carrier
    When I confirm my email address
    Then I will be registered as a lower tier waste carrier
     And I have received an registration complete email
     And the registration status will be "Registered"

@smoke
 Scenario: Lower tier waste carrier does not confirm their email address
  Given I complete my application of my limited company "Unconfirmed company ltd" as a lower tier waste carrier
    But I do not confirm my email address
   Then my registration status for "Unconfirmed company ltd" will be "Pending"
