@frontoffice @upper_tier @renewal
Feature: Limited company renews for new upper tier registration
  As a carrier of commercial waste
  I want to renew my waste carrier licence
  So I continue to be compliant with the law

Background:
      Given my limited company with companies house number "00445790" registers as an upper tier waste carrier
      And I confirm my email address
      And I choose to renew my registration using my previous registration number
      And I have signed into my account
     When I choose to renew my registration from my registrations list  
  
Scenario: Limited company successfully renews registration paying by credit card
     When I complete my limited company registration without changing any information paying by credit card
     Then I will have renewed my registration
      And a renewal confirmation email is received

  Scenario: Limited company successfully renews registration paying by bank transfer
     When I complete my limited company registration without changing any information paying by bank transfer
     Then I will be informed my renewal is received
  


