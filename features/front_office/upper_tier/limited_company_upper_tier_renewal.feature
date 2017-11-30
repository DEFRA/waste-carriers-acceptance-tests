@frontoffice @upper_tier @renewal @wip
Feature: Limited company renews for new upper tier registration
  As a carrier of commercial waste
  I want to renew my waste carrier licence
  So I continue to be compliant with the law
  
Scenario: Limited company successfully renews registration 
    Given my limited company with companies house number "00445790" registers as an upper tier waste carrier
      And I confirm my email address
      And I choose to renew my registration using my previous registration number
      And I have signed into my account
     When I choose to renew my registration from my registrations list
      And I complete my limited company registration without changing any information
     Then I will have renewed my registration
      And a registration confirmation email is received


