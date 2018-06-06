@frontoffice @upper_tier @smoke
Feature: Upper tier registration deletes registration
  As a carrier of commercial waste
  I want to be able to remove any registration that is not required
  So that I don't have any registrations associated to me that I don't want

  Scenario: Limited company changing its carrier type incurs a charge
  Given I choose to delete my registration "CBDU118"
   When I delete my registration
   Then I will not see registration "CBDU118" in my registrations list
