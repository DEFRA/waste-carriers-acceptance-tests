@fo_new @fo_dashboard
Feature: Waste carrier accessed their front office dashboard
  As a carrier of commercial waste
  I want to be able to view my registrations online
  So that I know I'm correctly registered for my waste carrier activities

  Background:
    Given I have an active registration

  Scenario: Reset password
    When I forget my front office password and reset it
    Then I can log in with the new password
    And I can reset it to its original value

  Scenario: View certificate from front office dashboard
    When I choose to view my certificate
    Then I can view my certificate of registration
    And I can access the footer links
