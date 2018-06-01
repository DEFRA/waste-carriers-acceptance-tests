@backoffice @finance @smoke @todod
Feature: Writing off an amount of money owed by a registration
As a finance admin
I want to be able to adjust the charge associated to a registration
So that the amount owed reflects what is actually owed

 Scenario: Agency user with refund privileges can write off a small amount of money owed to enable application registration (less than five pounds)
  Given I have a registration "CBDU116"
    And I am signed in as a finance admin
   When I add a charge of £20 to the registration
   Then the outstanding balance will be £20