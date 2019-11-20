@fo_new @upper_tier @fo_dashboard
Feature: Waste carrier views certificate from user registrations dashboard
  As a carrier of commercial waste
  I want to be able to view my registration certificate
  So that I know I'm correctly registered for my waste carrier activities

  Background:
  Given I have registration "CBDU118"
   When I choose to view my certificate for "CBDU118"

  Scenario: Limited company changing its carrier type incurs a charge
   Then I can view my certificate of registration

  Scenario: Check that the footer links work
    And I can access the footer links
