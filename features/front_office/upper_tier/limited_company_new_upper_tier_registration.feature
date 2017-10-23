@frontoffice @upper_tier
Feature: Limited company applies for new upper tier registration
  As a carrier of commercial waste
  I want to register my company with the Environment Agency
  So I am compliant with the law
   

  Scenario: Limited company successfully registers for a upper tier waste carriers licence paying by credit card
   Given I start a new registration
   	When I complete my application of my limited company as an upper tier waste carrier
   	 And I pay for my appliction by maestro ordering 5 copy cards
   	Then I will be registered as an upper tier waste carrier
