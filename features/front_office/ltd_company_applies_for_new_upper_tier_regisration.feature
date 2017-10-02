@frontoffice @wip
Feature: Limited company applies for new upper tier registration
  As a carrier of domestic waste
  I want to register my company with the Environment Agency
  So I am compliant with the law
   

  Scenario: Limited company successfully registers for a upper tier waste carriers licence
   Given I start a new registration
   	When I complete my registration of my limited company as a upper tier waste carrier
   	Then I will be registered as an upper tier waste carrier
