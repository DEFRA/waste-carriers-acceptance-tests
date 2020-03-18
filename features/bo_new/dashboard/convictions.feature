@bo_new @upper_tier @convictions @smoke @bo_reg
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

    Given NCCC partially renews an existing registration with "convictions"
      And the applicant pays by bank card
      And the registration has a status of "CONVICTIONS"

     When the conviction check is flagged by an agency user
      And the flagged conviction is approved by an agency user

     Then the registration does not have a status of "CONVICTIONS"
      And the registration does not have a status of "IN PROGRESS"

  Scenario: A partnership with a declared conviction is flagged, approved, renewed and rejected
    Given a conviction is declared when registering their partnership for an upper tier waste carrier
      And the registration has a status of "CONVICTIONS"

     When the conviction check is flagged by an agency user
      And the flagged conviction is approved by an agency user

     Then the registration has a status of "ACTIVE"
      And the registration does not have a status of "CONVICTIONS"
  	  And the registration status in the registration export is set to "ACTIVE"

    Given NCCC partially renews an existing registration with "convictions"
      And the applicant pays by bank card
      And the registration has a status of "CONVICTIONS"

     When the conviction check is flagged by an agency user
      And the flagged conviction is rejected by an agency user

     Then the registration has a status of "CONVICTIONS"
      And the registration has a status of "REVOKED"

  Scenario: Limited company with an undeclared conviction match by name is marked for a conviction check and rejected
    Given a limited company "CACI" registers as an upper tier waste carrier
      And the registration has a status of "CONVICTIONS"

      When the conviction check is flagged by an agency user
       And the flagged conviction is rejected by an agency user

      Then the registration has a status of "REFUSED"
       And the registration has a status of "CONVICTIONS"

  Scenario: Registration is not completed if there is an outstanding conviction
     Given an Environment Agency user has signed in to the backend
       And NCCC partially registers an upper tier "carrier_broker_dealer" "partnership" with "convictions"
       And the applicant chooses to pay for the registration by bank transfer ordering 1 copy card
       And the registration's balance is 159

      When NCCC pays the remaining balance by "cash"
      Then the registration has a status of "IN PROGRESS"
       And the registration has a status of "CONVICTIONS"
       And the registration does not have a status of "PAYMENT NEEDED"
