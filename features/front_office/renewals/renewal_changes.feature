@frontoffice @upper_tier @renewal
Feature: Registered waste carrier chooses to renew their registration from start page
  As a carrier of commercial waste
  I want to change my registration details when I renew my waste carriers licence with the Environment Agency
  So my details are up to date and I continue to be compliant with the law

    Scenario: Limited company changes business type and is informed to create a new registration
      Given I renew my registration using my previous registration number "CBDU216"
        And I have signed in to renew my registration
        But I change the business type to "Local authority or public body"
       Then I will be notified "You need a new registration"

   Scenario: Sole trader changes place of business location to outside the UK
      Given I renew my registration using my previous registration number "CBDU217"
        And I have signed in to renew my registration
        But I change my place of business location to "Not in the United Kingdom"
       Then I will be able to continue my renewal

   Scenario: Sole trader changes place of business location to Northern Ireland
      Given I renew my registration using my previous registration number "CBDU208"
        And I have signed in to renew my registration
        But I change my place of business location to "Northern Ireland"
       Then I will be notified "You can register in Northern Ireland"
 
  Scenario: Sole trader changes place of business location to Scotland
      Given I renew my registration using my previous registration number "CBDU209"
        And I have signed in to renew my registration
        But I change my place of business location to "Scotland"
       Then I will be notified "You can register in Scotland"

  Scenario: Sole trader changes place of business location to Wales
      Given I renew my registration using my previous registration number "CBDU210"
        And I have signed in to renew my registration
        But I change my place of business location to "Wales"
       Then I will be notified "You can register in Wales"

    Scenario: On renewal a partnership changes its registration type causing a £40 charge for the change
      Given I renew my registration using my previous registration number "CBDU223"
        And I have signed in to renew my registration
       When I change my carrier broker dealer type to "We do both (carrier, broker and dealer)"
       Then I will be advised "Because your carrier type has changed, there will also be a £40 charge"

    Scenario: On renewal a sole trader answers questions that direct to lower tier
      Given I renew my registration using my previous registration number "CBDU224"
        And I have signed in to renew my registration
       When I answer questions indicating I should be a lower tier waste carrier
       Then I will be notified "You can register as a lower tier waste carrier"

  Scenario: Partnership changes business type to Limited Liability Partnership
      Given I renew my registration using my previous registration number "CBDU211"
        And I have signed in to renew my registration
        But I change the business type to "Limited liability partnership"
       Then I will be able to continue my renewal

  Scenario: Limited company changes business type to Limited Liability Partnership
      Given I renew my registration using my previous registration number "CBDU205"
        And I have signed in to renew my registration
        But I change the business type to "Limited liability partnership"
       Then I will be able to continue my renewal

  Scenario: Limited company changes companies house number and is informed to create a new registration
      Given I renew my registration using my previous registration number "CBDU206"
        And I have signed in to renew my registration
        But I change my companies house number to "10926928"
       Then I will be notified "You cannot renew"






