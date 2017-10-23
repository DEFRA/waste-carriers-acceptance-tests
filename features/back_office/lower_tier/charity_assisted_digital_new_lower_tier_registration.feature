@backoffice @lower_tier @ad
Feature: Assisted digital registration of a charity
  As a carrier of domestic waste
  I want assistance with my waste carrier registration from the Environment Agency
  So I can complete my regisration and I am compliant with the law
   
   Background:
   Given an Environment Agency user has signed in

  Scenario: Charity successfully registers for a lower tier waste carriers licence
   Given I request assistance with a new registration
   	When I have my registration of my charity as a lower tier waste carrier completed for me
   	Then I will have a lower tier registration
   	
     
