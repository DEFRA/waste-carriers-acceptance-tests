@frontoffice @lower_tier

Feature: Public body applies for new lower tier registration
  As a carrier of domestic waste
  I want to register my company with the Environment Agency
  So I am compliant with the law
   

  Scenario: Public body successfully registers for a lower tier waste carriers licence
   Given I start a new registration
   	When I complete my registration of my public body as a lower tier waste carrier
   	Then I will be asked to confirm my email address