@backoffice @upper_tier
Feature: Assisted digital registration of an upper tier public body
  As a carrier of commerical waste
  I want assistance with my waste carrier registration from the Environment Agency
  So I can complete my regisration and I am compliant with the law
   
   Background:
   Given an Environment Agency user has signed in
     And I request assistance with a new registration
    When I have my public body upper tier waste carrier application completed for me

  Scenario: NCCC successfully registers a public body for a upper tier waste carriers licence paying by credit card

   	When I pay for my appliction over the phone by maestro ordering 0 copy cards
   	Then I will have an upper tier registration

  Scenario: NCCC successfully registers a public body for a upper tier waste carriers licence choosing to pay by bank transfer
    When I choose to pay for my application by bank transfer ordering 3 copy cards
    Then I will be informed by the person taking the call that registration is pending payment  
   	
     