# frozen_string_literal: true

Then("I sign in as an agency user") do
  login_backend_user(@world.agency_user)
end

Given(/^I sign in as a agency with payment refund user$/) do
  login_backend_user(@world.agency_with_payment_refund_user)
end

Given(/^I sign in as (?:a|an) finance admin agent$/) do
  login_backend_user(@world.finance_admin_user)
end

Given(/^I sign in as a finance basic user/) do
  login_backend_user(@world.finance_basic_user)
end

Given(/^I sign in as (?:a|an) agency super user/) do
  login_backend_user(@world.agency_super_user)
end

Then("I sign in as an admin user") do
  login_backend_admin(@world.agency_super_user)
end
