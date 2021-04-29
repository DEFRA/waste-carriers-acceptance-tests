@bo
Feature: Back office registration actions

    Actions that can be carried out on a registration in the back office

      Scenario: Limited company has their upper tier registration renewed by NCCC
        Given I have a new registration for a "limitedCompany" business
        And I sign into the back office as "agency-user"
        And I view the registration details
        And I resend the confirmation email
        Then I will see the renewal reminder email has been sent
        And I will receive a registration renewal reminder email