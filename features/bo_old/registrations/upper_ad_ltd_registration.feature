@bo_old @upper_tier @bo_reg
Feature: Assisted digital registration of an upper tier Limited company
  As a carrier of commerical waste
  I want assistance with my waste carrier registration from the Environment Agency
  So I can complete my regisration and I am compliant with the law

   Background:
   Given an Environment Agency user has signed in to the backend
     And I request assistance with a new registration
    When I have my limited company as a upper tier waste carrier application completed for me

  Scenario: NCCC successfully registers a limited company for a upper tier waste carriers licence paying by credit card
    When I pay for my application over the phone by maestro ordering 2 copy cards
   	Then I will have an upper tier registration
     And the registration status will be "Registered"

@smoke
  Scenario: NCCC successfully registers a limited company for a upper tier waste carriers licence choosing to pay by bank transfer
    When the applicant chooses to pay for the registration by bank transfer ordering 4 copy cards
    Then the registration status will be "Awaiting payment"
