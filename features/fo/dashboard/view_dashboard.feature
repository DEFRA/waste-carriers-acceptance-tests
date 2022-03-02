@fo @fo_dashboard
Feature: Waste carrier accesses their front office dashboard
  As a carrier of commercial waste
  I want to be able to view my registrations online
  So that I know I'm correctly registered for my waste carrier activities

  Background:
    Given I create an upper tier registration for my "limitedCompany" business as "wcr-user@example.com"

  Scenario: Reset and change password
    When I forget my front office password and reset it
    Then I can log in with the updated password

    When I change the password back to its original value
    Then I can log in with the updated password

  Scenario: View certificate from front office dashboard
    When I choose to view my certificate
    Then I can view my certificate of registration
    And I can access the footer links
