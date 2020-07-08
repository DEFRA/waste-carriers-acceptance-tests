@fo_new @fo_dashboard
Feature: Waste carrier views certificate from user registrations dashboard
  As a carrier of commercial waste
  I want to be able to view my registration certificate
  So that I know I'm correctly registered for my waste carrier activities

  Background:
    Given I have an active registration
    When I choose to view my certificate
    Then I can view my certificate of registration
    And I can access the footer links
