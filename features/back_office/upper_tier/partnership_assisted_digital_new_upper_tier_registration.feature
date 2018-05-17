@backoffice @upper_tier
Feature: Assisted digital registration of an upper tier partnership
  As a carrier of commerical waste
  I want assistance with my waste carrier registration from the Environment Agency
  So I can complete my regisration and I am compliant with the law
   
   Background:
   Given an Environment Agency user has signed in
     And I request assistance with a new registration
    When I have my partnership upper tier waste carrier application completed for me

  Scenario: NCCC successfully registers a partnership for a upper tier waste carriers licence paying by credit card
    When I pay for my application over the phone by maestro ordering 2 copy cards
   	Then I will have an upper tier registration
     And the registration status will be "Registered"
     
@smoke 
  Scenario: NCCC successfully registers a partnership for a upper tier waste carriers licence choosing to pay by bank transfer
    When I ask to pay for my application by bank transfer ordering 1 copy card
    Then I will be informed by the person taking the call that registration is pending payment   
   	 And the registration status will be "Awaiting payment"
     
