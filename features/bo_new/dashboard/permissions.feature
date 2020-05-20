@bo_new @bo_dashboard @smoke
Feature: Check back office permissions
  As a system administrator
  I want to ensure users can only access what they need to
  So that no mistakes are made

Background:
  Given I have an active registration
    And NCCC makes a payment of 5 by "cash"
    And I sign out of back office
    And I have a pending registration

Scenario: Permissions
   When I sign into the back office as "agency-user"
   Then I have the correct permissions for an agency user

   When I sign into the back office as "agency-refund-payment-user"
   Then I have the correct permissions for an agency refund payment user

   When I sign into the back office as "agency-super"
   Then I have the correct permissions for an agency super user

   When I sign into the back office as "finance-user"
   Then I have the correct permissions for a finance user

   When I sign into the back office as "finance-admin-user"
   Then I have the correct permissions for a finance admin user

   When I sign into the back office as "finance-super"
   Then I have the correct permissions for a finance super user
