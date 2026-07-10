Feature: Users can unsubscribe from renewal reminder emails

Scenario: User can unsubscibe from renewal reminder emails in registration confirmation email
  Given I create an upper tier registration for my "soleTrader" business
    And I receive a registration confirmation email
   When I unsubscribe from the renewal reminder emails
   Then I will see confirmation that I have unsubscibed
    And I open communication message from the communication history
    And the unsubscription is logged in the communications history

Scenario: User can unsubscibe from renewal reminder emails in renewal invite email
  Given I create an upper tier registration for my "soleTrader" business
    And I receive an email inviting me to renew
   When I unsubscribe from the renewal reminder emails
   Then I will see confirmation that I have unsubscibed
    And I open communication message from the communication history
    And the unsubscription is logged in the communications history