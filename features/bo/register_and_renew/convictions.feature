@bo @bo_reg @convictions   
Feature: Conviction checks during upper tier waste carrier registrations
  As a waste carrier administrator
  I want to check whether any known companies or individuals have any previous waste convictions
  So that I can decide whether they are allowed to hold a waste carriers licence

  (Registrations are completed on the front office for this feature.)
  @email
  Scenario: Limited company with an undeclared conviction match by company number is marked for a conviction check
    Given a limited company with companies house number "01649776" is registered as an upper tier waste carrier
    And the registration has a status of "CONVICTIONS"
    And an application confirmation email will be sent
    When the conviction check is immediately approved by an NCCC user
    Then the registration has a status of "ACTIVE"
    And the registration does not have a status of "CONVICTIONS"
    And a registraton confirmation email will be sent
  
  Scenario: Sole trader with an undeclared conviction match by name is marked for a conviction check
    Given I have a new registration for a "soleTrader" with business name "Undeclared conviction"
    And NCCC partially renews an existing registration with "convictions"
    And the applicant pays by bank card
    And the renewal has a status of "CONVICTIONS"
    When the conviction check is flagged by an NCCC user
    And the flagged conviction is approved by an NCCC user
    Then the registration does not have a status of "CONVICTIONS"
    And the registration does not have a status of "IN PROGRESS"

  Scenario: A partnership with a declared conviction is flagged and approved
    Given a conviction is declared when registering their partnership for an upper tier waste carrier
    And the registration has a status of "CONVICTIONS"
    When the conviction check is flagged by an NCCC user
    And the flagged conviction is approved by an NCCC user
    Then the registration has a status of "ACTIVE"
    And the registration does not have a status of "CONVICTIONS"

  Scenario: Partnership with an undeclared conviction match by name is marked for a conviction check and rejected
    Given a partnership "Test Waste Services Ltd." registers as an upper tier waste carrier
    And the registration has a status of "CONVICTIONS"
    When the conviction check is flagged by an NCCC user
    And the flagged conviction is rejected by an NCCC user
    Then the registration has a status of "REFUSED"
    And the registration has a status of "CONVICTIONS"

  Scenario: Registration is not completed if there is an outstanding conviction
    Given a registration with declared convictions is submitted with outstanding payment
    When NCCC pays the remaining balance by "cash"
    Then the registration has a status of "IN PROGRESS"
    And the registration has a status of "CONVICTIONS"
    And the registration does not have a status of "PAYMENT NEEDED"
