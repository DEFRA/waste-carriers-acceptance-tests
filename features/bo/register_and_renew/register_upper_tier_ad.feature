@bo @bo_reg
Feature: Assisted digital upper tier registrations
  As a carrier of commercial waste
  I want assistance with my waste carrier registration from the Environment Agency
  So I can complete my regisration and I am compliant with the law

  @smoke @email @card
  Scenario: Successful partnership registration from back office via GovPay
    Given I sign into the back office as "agency-user"
    When I register an upper tier "partnership" from the back office
    And I pay by card
    Then I am notified that my registration has been successful
    And the registration has a status of "ACTIVE"
    And a registraton confirmation email will be sent

  @letter
  Scenario: Upper tier partnership with no contact email registered from back office
    Given I sign into the back office as "agency-user"
    When I register a "partnership" from the back office with no contact email
    And I pay by card
    Then I am notified that my registration has been successful
    And a registraton confirmation letter will be sent

  @email
  Scenario: Successful LLP registration from back office via bank transfer
    Given I sign into the back office as "agency-user"
    When I register an upper tier "limitedLiabilityPartnership" from the back office
    And I pay by bank transfer
    Then I am notified that I need to pay by bank transfer
    And I am sent an email advising me how to pay by bank transfer
    And the registration has a status of "IN PROGRESS"
    And the registration has a status of "PAYMENT NEEDED"
