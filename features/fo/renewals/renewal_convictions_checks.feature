@fo @fo_renew @convictions @email
Feature: Registered waste carrier declares conviction during renewal
  As a member of the waste carriers team in NCCC
  I want to be informed of any potential matches with the Environment Agency's convictions database
  So that I can then target my investigation of registration suitability to the right people

  Scenario: Limited company renews upper tier registration from renewals page declaring conviction
    Given I create an upper tier registration for my "limitedCompany" business as "another-user@example.com"
    And I start renewing this registration from the start page
    And I have signed in to renew my registration as "another-user@example.com"
    When I complete my limited company renewal steps declaring a conviction
    Then I will be notified my renewal is pending checks
    And I will receive a registration renewal pending checks email

  Scenario: Limited company renews upper tier registration from renewals page not declaring conviction
    Given I create a new registration as "user@example.com"
    And I start renewing this registration from the start page
    And I have signed in to renew my registration as "user@example.com"
    When I complete my limited company renewal steps not declaring a personal conviction
    Then I will be notified my renewal is pending checks
    And I will receive a registration renewal pending checks email
 
  Scenario: Limited company renews upper tier registration from renewals page not declaring company conviction
    Given I have an active registration with a company number of "01649776"
    And I start renewing this registration from the start page
    And I have signed in to renew my registration as "user@example.com"
    When I complete my limited company renewal steps not declaring a company conviction
    Then I will be notified my renewal is pending checks
    And I will receive a registration renewal pending checks email
