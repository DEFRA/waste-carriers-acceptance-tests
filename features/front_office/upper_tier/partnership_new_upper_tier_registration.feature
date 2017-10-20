@frontoffice @wip @upper_tier
Feature: Partnership applies for new upper tier registration
  As a carrier of commercial waste
  I want to register my company with the Environment Agency
  So I am compliant with the law
   

  Scenario: Partnership successfully registers for a upper tier waste carriers licence
   Given I start a new registration
   	When I complete my aplication of my partnership as a upper tier waste carrier
   	 And I pay for my appliction by maestro ordering 2 copy cards
   	Then I will be registered as an upper tier waste carrier
