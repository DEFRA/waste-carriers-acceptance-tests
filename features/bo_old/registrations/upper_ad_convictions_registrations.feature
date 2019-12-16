@bo_old @upper_tier @convictions @smoke @bo_reg
Feature: Conviction checks during upper tier waste carrier registrations
  As a waste carrier administrator
  I want to check whether any known companies or individuals have any previous waste convictions
  So that I can decide whether they are allowed to hold a waste carriers licence

   Background:
   Given an Environment Agency user has signed in to the backend

  Scenario: Limited company with an undeclared conviction match by company number is marked for a conviction check
  	Given a limited company with companies house number "01649776" is registered as an upper tier waste carrier
      And the registration has a status of "CONVICTIONS"

  	 When the conviction check is immediately approved by an agency user

     Then the registration has a status of "ACTIVE"
      And the registration does not have a status of "CONVICTIONS"
  	  And the registration status in the registration export is set to "ACTIVE"

  Scenario: Sole trader with an undeclared conviction match by name is marked for a conviction check
    Given a key person with a conviction registers as a sole trader upper tier waste carrier
      And the registration has a status of "CONVICTIONS"

     When the conviction check is immediately approved by an agency user

     Then the registration has a status of "ACTIVE"
      And the registration does not have a status of "CONVICTIONS"
  	  And the registration status in the registration export is set to "ACTIVE"

  Scenario: A partnership with a declared conviction is marked for a conviction check
    Given a conviction is declared when registering their partnership for an upper tier waste carrier
      And the registration has a status of "CONVICTIONS"

     When the conviction check is flagged by an agency user
      And the flagged conviction is approved by an agency user

     Then the registration has a status of "ACTIVE"
      And the registration does not have a status of "CONVICTIONS"
  	  And the registration status in the registration export is set to "ACTIVE"

  Scenario: Limited company with an undeclared conviction match by name is marked for a conviction check and rejected
    Given a limited company "CACI" registers as an upper tier waste carrier
      And the registration has a status of "CONVICTIONS"

      When the conviction check is flagged by an agency user
       And the flagged conviction is rejected by an agency user

      Then the registration has a status of "REFUSED"
       And the registration has a status of "CONVICTIONS"
