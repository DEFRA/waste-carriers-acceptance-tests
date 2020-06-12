@fo_new @fo_renew
Feature: Registered waste carrier chooses to renew their registration by email
  As a carrier of commercial waste
  I want to renew my waste carriers licence with the Environment Agency
  So I continue to be compliant with the law

  Scenario: [RUBY-987] Renew from email via magic link
    Given I create an upper tier registration for my "soleTrader" business as "user@example.com"
    And I receive an email from NCCC inviting me to renew
    When I renew from the email
    Then I will be notified my renewal is complete
    And I will receive an email informing me "Your registration as an upper tier waste carrier, broker and dealer has been renewed"
    And I cannot renew again with the same link

  Scenario: Cannot renew with invalid token
    Given I create an upper tier registration for my "soleTrader" business as "user@example.com"
    When I incorrectly paste its renewal link
    Then I am told the renewal cannot be found

# @wip
#   Scenario: Cannot renew registration outside grace window
#     Given I have a registration which expired 90 days ago
#     When I call NCCC to renew it
#     Then NCCC are unable to generate a renewal email
