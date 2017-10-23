@frontoffice @upper_tier @wip
Feature: Public body applies for new upper tier registration
  As a carrier of commercial waste
  I want to register my company with the Environment Agency
  So I am compliant with the law
   

  Scenario: Public body successfully registers for a upper tier waste carriers licence paying by credit card
   Given I start a new registration
   	When I complete my application of my public body as an upper tier waste carrier
   	 And I pay for my appliction by maestro ordering 1 copy card
   	Then I will be registered as an upper tier waste carrier
