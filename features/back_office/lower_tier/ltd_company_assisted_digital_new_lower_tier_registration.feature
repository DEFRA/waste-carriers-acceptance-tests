@backoffice
Feature: Assisted digital registration of an lower tier Limited company
  As a carrier of domestic waste
  I want assistance with my waste carrier registration from the Environment Agency
  So I can complete my regisration and I am compliant with the law
   
   Background:
   Given an Environment Agency user has signed in

  Scenario: Limited company successfully registers for a lower tier waste carriers licence
   Given I request assistance with a new registration
   	When I have my limited company as a lower tier waste carrier registration completed for me
   	Then I will have a lower tier registration
   	
     
