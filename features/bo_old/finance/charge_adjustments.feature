@bo_old @bo_finance
Feature: Writing off an amount of money owed by a registration
As a finance admin
I want to be able to adjust the charge associated to a registration
So that the amount owed reflects what is actually owed

 Scenario: Finance admin can add a positive charge to a registration
  Given I have a registration "CBDU116"
    And I am signed in as a finance admin
   When I add a positive charge of £20 to the registration
   Then the outstanding balance will be £20

Scenario: Finance admin can add a positive charge to a registration
  Given I have a registration "CBDU117"
    And I am signed in as a finance admin
   When I add a negative charge of £40 to the registration
   Then the overpaid amount will be £40
