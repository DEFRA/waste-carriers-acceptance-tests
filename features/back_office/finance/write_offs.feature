@backoffice @finance @smoke 
Feature: Writing off an amount of money owed by a registration
As a back office user
I want to be be able to write off an amount of money owed to the Environment agency
So that registration is completed

 Scenario: Agency user with refund privileges can write off a small amount of money owed to enable application registration (less than five pounds)
  Given I have a registration "CBDU113"
    And I am signed in as an Environment Agency user with refunds
   When I write off the small amount owed
   Then the payment status will be marked as paid
    And the registration will be marked as "Registered"
@todod
  Scenario: Agency user with refund privileges can not write off an amount over five pounds
  Given I have a registration "CBDU114"
    And I am signed in as an Environment Agency user with refunds
   When I view the registrations payment summary
   Then I am unable to write off the amount owed
