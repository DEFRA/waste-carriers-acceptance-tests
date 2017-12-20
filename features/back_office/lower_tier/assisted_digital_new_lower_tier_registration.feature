@backoffice @lower_tier @ad 
Feature: Assisted digital lower tier registrations
  As a carrier of domestic waste
  I want assistance with my waste carrier registration from the Environment Agency
  So I can complete my regisration and I am compliant with the law
   
   Background:
   Given an Environment Agency user has signed in

 Scenario: NCCC successfully registers a charity with a lower tier waste carriers licence
   Given I request assistance with a new registration
   	When I have my registration of my charity as a lower tier waste carrier completed for me
   	Then I will have a lower tier registration
     And the registration status will be "Registered"

 Scenario: NCCC successfully registers a local authority with a lower tier waste carriers licence
   Given I request assistance with a new registration
    When I have my registration of my local authority as a lower tier waste carrier completed for me
    Then I will have a lower tier registration
     And the registration status will be "Registered"


 Scenario: NCCC successfully registers a limited company with a lower tier waste carriers licence
   Given I request assistance with a new registration
    When I have my registration of my limited company as a lower tier waste carrier completed for me
    Then I will have a lower tier registration
      And the registration status will be "Registered"

   	
 Scenario: NCCC successfully registers a partnership with a lower tier waste carriers licence
   Given I request assistance with a new registration
    When I have my registration of my partnership as a lower tier waste carrier completed for me
    Then I will have a lower tier registration 
     And the registration status will be "Registered"
   

 Scenario: NCCC successfully registers a public body with a lower tier waste carriers licence
   Given I request assistance with a new registration
    When I have my registration of my public body as a lower tier waste carrier completed for me
    Then I will have a lower tier registration
     And the registration status will be "Registered"


 Scenario: NCCC successfully registers a sole trader with a lower tier waste carriers licence
   Given I request assistance with a new registration
    When I have my sole trader business lower tier waste carrier registration completed for me
    Then I will have a lower tier registration
     And the registration status will be "Registered"
