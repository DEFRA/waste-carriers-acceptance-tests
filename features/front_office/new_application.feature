@frontoffice
Feature: New application
  As Eleanor a director of a limited company
  I need to get an anerobic digestion permit
  So that I know that I'm operating in a legal manner

  Background:
    Given I have started a new application
      And I have given my email details to save my application

  Scenario: Limited company successfully applies for an anaerobic digestion SR2010 No 17 standard rules permit
    When I select an "Anaerobic digestion" standard rules permit "SR-2010-17"
     And I complete my application
    Then I will see confirmation my application has been submitted
     And I should see my application reference
