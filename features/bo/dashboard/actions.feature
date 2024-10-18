@bo
Feature: Back office registration actions

    Actions that can be carried out on a registration in the back office
      @email
      Scenario: Renewal reminder email can be resent from back office
        Given I have a new registration for a "limitedCompany" business
        And I sign into the back office as "agency-user"
        And I view the registration details
        And I resend the renewal reminder email
        Then I will see the renewal reminder email has been sent
        And I will receive a registration renewal reminder email
        And I can see the communication logs on the communication history page

      @email @certificate
      Scenario: Registration confirmation email can be resent from the back office
        Given I have a new registration for a "limitedCompany" business
        And I sign into the back office as "agency-user"
        And I view the registration details
        And I resend the confirmation email
        Then I will see the registration confirmation email has been sent
        And I will receive a registration confirmation email
        And the registration certificate can be viewed from the email
      
      Scenario: Companies house registred name can be updated for companies from the back office
        Given I have a new registration for a "limitedCompany" business
        And I sign into the back office as "agency-user"
        And I view the registration details
        When I refresh the company name from companies house
        Then I can see the company name has been updated

