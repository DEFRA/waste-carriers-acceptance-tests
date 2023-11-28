@fo @fo_renew
Feature: Registered waste carrier chooses to renew their registration by email
  As a carrier of commercial waste
  I want to renew my waste carriers licence with the Environment Agency
  So I continue to be compliant with the law

  @email @smoke
  Scenario: [RUBY-987] Renew from email via magic link
    Given I create an upper tier registration for my "soleTrader" business
    And I receive an email from NCCC inviting me to renew
    When I renew from the email as a "soleTrader"
    Then I will be notified my renewal is complete
    And I will receive a registration renewal confirmation email
    And I cannot renew again with the same link

  Scenario: Cannot renew with invalid token
    Given I create an upper tier registration for my "soleTrader" business
    When I incorrectly paste its renewal link
    Then I am told the renewal cannot be found

  # Requires registration expiry to be within WCRS_REGISTRATION_GRACE_WINDOW range
  @email
  Scenario: Renew expired registration just inside grace window
    Given I have a registration which expired 4 days ago
    And I receive an email from NCCC inviting me to renew
    When I renew from the email as a "soleTrader"
    Then I will be notified my renewal is complete
    And I will receive a registration renewal confirmation email

  Scenario: Cannot renew registration outside user grace window
    Given I have a registration which expired 5 days ago
    When I call NCCC to renew it
    Then NCCC are unable to generate a renewal email
    And there is no option to renew the registration

  Scenario: Inactive limited company is unable to renew
    Given mocking is "disabled"
    And I have a company registration with an inactive companies house number
    And I receive an email from NCCC inviting me to renew
    When I start the renew from the email
    Then I will be informed my companies house number could not be validated