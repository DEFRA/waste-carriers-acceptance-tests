@frontoffice @upper_tier

Feature: Sole trader applies for new upper tier registration
  As a carrier of commercial waste
  I want to register my company with the Environment Agency
  So I am compliant with the law
   

  Scenario: Sole trader successfully registers for a upper tier waste carriers licence paying by credit card
   Given I start a new registration
   	When I complete my application of my sole trader business as a upper tier waste carrier
   	 And I pay for my appliction by maestro ordering 2 copy cards
    Then I will be registered as an upper tier waste carrier

