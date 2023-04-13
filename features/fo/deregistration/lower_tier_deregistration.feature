@dereg
Feature: Lower tier deregistration

As a user 
I want to be able to deregister my lower tier registration 
so that I can confirm I no longer need a lower tier registration

Scenario: Lower tier registration can be deregistered by the customer
    Given I create a lower tier registration for my "charity" business as "user@example.com"
     When I select the link to deregister my registration
      And I confirm I want to cancel my registration
     Then I will be informed my registration is deregistered
     
@email
Scenario: Lower tier deregisration invite email is resent if link has expired
  Given I create a lower tier registration with an expired deregistration link
    And I select the link to deregister my registration
    And I am sent an new deregisration invite email
   When I select the link to deregister my registration
    And I confirm I want to cancel my registration
   Then I will be informed my registration is deregistered
