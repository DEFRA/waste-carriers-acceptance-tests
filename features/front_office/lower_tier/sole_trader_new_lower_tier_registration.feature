@frontoffice @lower_tier

Feature: Sole trader applies for new lower tier registration
  As a carrier of domestic waste
  I want to register my company with the Environment Agency
  So I am compliant with the law
   

  Scenario: Sole trader successfully registers for a lower tier waste carriers licence
   Given I start a new registration
   	When I complete my registration of a sole trader business as a lower tier waste carrier
   	Then I will be asked to confirm my email address
