@backoffice
Feature: Assisted digital registration of an upper tier Limited company
  As a carrier of commerical waste
  I want assistance with my waste carrier registration from the Environment Agency
  So I can complete my regisration and I am compliant with the law
   
   Background:
   Given an Environment Agency user has signed in

  Scenario: Limited company successfully registers for a upper tier waste carriers licence
   Given I request assistance with a new registration
   	When I have my limited company as a upper tier waste carrier registration completed for me
   	Then I will have a upper tier registration
   	
     
