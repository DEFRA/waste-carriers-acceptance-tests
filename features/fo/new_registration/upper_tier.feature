@fo @fo_reg
Feature: A new user registers as an upper tier waste carrier
  As a carrier of commercial waste
  I want to register for an upper tier licence
  So I can be compliant with the law

  Background:
    Given I want to register as an upper tier carrier

  @smoke @email @card
  Scenario: A sole trader registers as an upper tier waste carrier and pays via GovPay
    When I start a new registration journey in "England" as a "soleTrader"
    And I complete my registration for my business "Happy Path UT Registration"
    And I pay by card
    Then I am notified that my registration has been successful
    And I will receive a registration confirmation email
    And the registration certificate can be viewed from the email
    
  @fix
  Scenario: Error while payment by card is retried successfully
    Given mocking is "disabled"
    And I start a new registration journey in "England" as a "soleTrader"
    And I complete my registration for my business "Happy Path UT Registration"
    When there is an error while paying by card
    And I retry and pay by card successfully
    Then I am notified that my registration has been successful
    
  @email
  Scenario: An LLP registers as an upper tier waste carrier and pays via bank transfer
    When I start a new registration journey in "England" as a "limitedLiabilityPartnership"
    And I complete my registration for my business "UT registration by bank transfer"
    And I pay by bank transfer
    Then I am notified that I need to pay by bank transfer
    And I am sent an email advising me how to pay by bank transfer
  
  Scenario: Upper tier Partnership business name is mandatory
   Given I start a new registration journey in "England" as a "partnership"
    And I am on the business name page
    When I submit the form
    Then I will be asked to enter a business name

