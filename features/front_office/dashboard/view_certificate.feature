@frontoffice @upper_tier
Feature: Waste carrier views certificate from user registrations dashboard
  As a carrier of commercial waste
  I want to be able to view my registration certificate
  So that I know I'm correctly registered for my waste carrier activities

  Scenario: Limited company changing its carrier type incurs a charge
  Given I have registration "CBDU118"
   When I choose to view my certificate for "CBDU118"
   Then I can view my certificate of registration