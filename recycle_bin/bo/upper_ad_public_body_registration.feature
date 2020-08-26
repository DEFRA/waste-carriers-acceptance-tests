Feature: Assisted digital registration of an upper tier public body
  As a carrier of commercial waste
  I want assistance with my waste carrier registration from the Environment Agency
  So I can complete my regisration and I am compliant with the law

  Background:
    Given an Environment Agency user has signed in to the backend
    And I request assistance with a new registration
    When I have my public body upper tier registration completed for me on backend

  Scenario: NCCC successfully registers a public body for a upper tier waste carriers licence paying by credit card
    When I pay for my application over the phone by maestro ordering 0 copy cards
    Then I will have an upper tier registration
    And the registration status will be "Registered"

  Scenario: NCCC successfully registers a public body for a upper tier waste carriers licence choosing to pay by bank transfer
    When the applicant chooses to pay for the registration by bank transfer ordering 3 copy cards
    Then the registration status will be "Awaiting payment"
