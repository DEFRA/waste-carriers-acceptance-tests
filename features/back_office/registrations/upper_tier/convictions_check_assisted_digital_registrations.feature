@backoffice @upper_tier @convictions @smoke
Feature: Conviction checks during upper tier waste carrier registrations
  As a waste carrier administrator
  I want to check whether any known companies or individuals have any previous waste convictions
  So that I can decide whether they are allowed to hold a waste carriers licence
   
   Background:
   Given an Environment Agency user has signed in


  Scenario: Limited company with an undeclared relevant conviction is marked for a conviction check during an upper tier registration taken by NCCC due to a match on its companies house number
  	Given a limited company with companies house number "01649776" is registered as an upper tier waste carrier
  	 When the limited company registration has the conviction check approved by an agency user
  	 Then the registration has a "Registered" status
  	  And the registration status in the registration export is set to "ACTIVE"

  Scenario: Sole trader with a relevant and undeclared relevant conviction is marked for a conviction check during an upper tier registration taken by NCCC
    Given a key person with a conviction registers as a sole trader upper tier waste carrier
     When the key person has the conviction check approved by an agency user
     Then the registration has a "Registered" status
      And the registration status in the registration export is set to "ACTIVE"


  Scenario: A partnership with a relevant declared conviction is marked for a conviction check during an upper tier registration taken by NCCC
    Given a conviction is declared when registering their partnership for an upper tier waste carrier
     When the key person has the conviction check approved by an agency user
     Then the registration has a "Registered" status
      And the registration status in the registration export is set to "ACTIVE"

  Scenario: Limited company with an undeclared relevant conviction is marked for a conviction check during an upper tier registration taken by NCCC due to a match on its company name
    Given a limited company "CACI" registers as an upper tier waste carrier
     When the limited company registration has the conviction check approved by an agency user
     Then the registration has a "Registered" status
      And the registration status in the registration export is set to "ACTIVE"