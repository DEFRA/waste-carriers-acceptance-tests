@backoffice
Feature: Assisted digital registration of a lower tier sole trader
  As a carrier of domestic waste
  I want assistance with my waste carrier registration from the Environment Agency
  So I can complete my regisration and I am compliant with the law
   
   Background:
   Given an Environment Agency user has signed in

  Scenario: NCCC successfully registers a sole trader for a lower tier waste carriers licence
   Given I request assistance with a new registration
   	When I have my sole trader business lower tier waste carrier registration completed for me
   	Then I will have a lower tier registration