@fo_new @upper_tier @fo_dashboard

Feature: Upper tier registration deletes registration
  As a carrier of commercial waste
  I want to be able to remove any registration that is not required
  So that I don't have any registrations associated to me that I don't want

  Scenario: User can delete their registration from their waste carrier registration dashboard
  Given I choose to delete my registration "CBDU119"
   When I delete my registration
   Then I will not see registration "CBDU119" in my registrations list
