Then(/^I have the correct permissions for an agency user$/) do
  visit_registration_details_page(@reg_number)
  expect(@bo.registration_details_page).to have_renew_link
  expect(@bo.registration_details_page).to have_transfer_link
  expect(@bo.registration_details_page).to have_edit_link
  expect(@bo.registration_details_page).to have_view_certificate_link
  expect(@bo.registration_details_page).to have_order_cards_link
  expect(@bo.registration_details_page).to have_payment_details_link
  expect(@bo.registration_details_page).to have_no_cease_or_revoke_link
  expect(@bo.registration_details_page.govuk_banner).to have_no_manage_users_link
  expect(@bo.registration_details_page.govuk_banner).to have_no_conviction_checks_link

  go_to_payments_page(@reg_number)
  expect(@bo.finance_payment_details_page).to have_no_enter_payment_button
  expect(@bo.finance_payment_details_page).to have_no_reverse_payment_button
  expect(@bo.finance_payment_details_page).to have_no_charge_adjust_button
  expect(@bo.finance_payment_details_page).to have_no_refund_button
  expect(@bo.finance_payment_details_page).to have_no_write_off_button

  # Permissions on pending registration
  visit_registration_details_page(@pending_reg_number)
  expect(@bo.registration_details_page).to have_no_cancel_link
end

Then(/^I have the correct permissions for an agency refund payment user$/) do
  visit_registration_details_page(@reg_number)
  expect(@bo.registration_details_page).to have_renew_link
  expect(@bo.registration_details_page).to have_transfer_link
  expect(@bo.registration_details_page).to have_edit_link
  expect(@bo.registration_details_page).to have_view_certificate_link
  expect(@bo.registration_details_page).to have_order_cards_link
  expect(@bo.registration_details_page).to have_payment_details_link
  expect(@bo.registration_details_page).to have_cease_or_revoke_link
  expect(@bo.registration_details_page.govuk_banner).to have_no_manage_users_link
  expect(@bo.registration_details_page.govuk_banner).to have_conviction_checks_link

  go_to_payments_page(@reg_number)
  expect(@bo.finance_payment_details_page).to have_enter_payment_button
  expect(@bo.finance_payment_details_page).to have_reverse_payment_button
  expect(@bo.finance_payment_details_page).to have_no_charge_adjust_button
  expect(@bo.finance_payment_details_page).to have_refund_button
  expect(@bo.finance_payment_details_page).to have_write_off_button

  # Permissions on pending registration
  visit_registration_details_page(@pending_reg_number)
  expect(@bo.registration_details_page).to have_cancel_link

  # Check agency-refund-payment-user cannot write off more than 5 pounds:
  sign_in_to_back_office("finance-admin-user")
  adjust_charge(1, 999) # adjust charge by +1 pound, passing a dummy number for second argument

  # Check that write off button is no longer available:
  sign_in_to_back_office("agency-user")
  go_to_payments_page(@reg_number)
  expect(@bo.finance_payment_details_page).to have_no_write_off_button

  # Set the balance back to 5 pounds for remaining tests
  sign_in_to_back_office("finance-admin-user")
  adjust_charge(-1, 999) # adjust charge by -1 pound, passing a dummy number for second argument
end

Then(/^I have the correct permissions for an agency super user$/) do
  visit_registration_details_page(@reg_number)
  expect(@bo.registration_details_page).to have_renew_link
  expect(@bo.registration_details_page).to have_transfer_link
  expect(@bo.registration_details_page).to have_edit_link
  expect(@bo.registration_details_page).to have_view_certificate_link
  expect(@bo.registration_details_page).to have_order_cards_link
  expect(@bo.registration_details_page).to have_payment_details_link
  expect(@bo.registration_details_page).to have_cease_or_revoke_link
  expect(@bo.registration_details_page.govuk_banner).to have_manage_users_link
  expect(@bo.registration_details_page.govuk_banner).to have_conviction_checks_link

  go_to_payments_page(@reg_number)
  expect(@bo.finance_payment_details_page).to have_enter_payment_button
  expect(@bo.finance_payment_details_page).to have_reverse_payment_button
  expect(@bo.finance_payment_details_page).to have_no_charge_adjust_button
  expect(@bo.finance_payment_details_page).to have_refund_button
  expect(@bo.finance_payment_details_page).to have_write_off_button

  # Permissions on pending registration
  visit_registration_details_page(@pending_reg_number)
  expect(@bo.registration_details_page).to have_cancel_link
end

Then(/^I have the correct permissions for a finance user$/) do
  visit_registration_details_page(@reg_number)
  expect(@bo.registration_details_page).to have_no_renew_link
  expect(@bo.registration_details_page).to have_no_transfer_link
  expect(@bo.registration_details_page).to have_no_edit_link
  expect(@bo.registration_details_page).to have_view_certificate_link
  expect(@bo.registration_details_page).to have_no_order_cards_link
  expect(@bo.registration_details_page).to have_payment_details_link
  expect(@bo.registration_details_page).to have_no_cease_or_revoke_link
  expect(@bo.registration_details_page.govuk_banner).to have_no_manage_users_link
  expect(@bo.registration_details_page.govuk_banner).to have_no_conviction_checks_link

  go_to_payments_page(@reg_number)
  expect(@bo.finance_payment_details_page).to have_enter_payment_button
  expect(@bo.finance_payment_details_page).to have_reverse_payment_button
  expect(@bo.finance_payment_details_page).to have_no_charge_adjust_button
  expect(@bo.finance_payment_details_page).to have_no_refund_button
  expect(@bo.finance_payment_details_page).to have_no_write_off_button

  # Permissions on pending registration
  visit_registration_details_page(@pending_reg_number)
  expect(@bo.registration_details_page).to have_no_cancel_link
end

Then(/^I have the correct permissions for a finance admin user$/) do
  visit_registration_details_page(@reg_number)
  expect(@bo.registration_details_page).to have_no_renew_link
  expect(@bo.registration_details_page).to have_no_transfer_link
  expect(@bo.registration_details_page).to have_no_edit_link
  expect(@bo.registration_details_page).to have_view_certificate_link
  expect(@bo.registration_details_page).to have_no_order_cards_link
  expect(@bo.registration_details_page).to have_payment_details_link
  expect(@bo.registration_details_page).to have_no_cease_or_revoke_link
  expect(@bo.registration_details_page.govuk_banner).to have_no_manage_users_link
  expect(@bo.registration_details_page.govuk_banner).to have_no_conviction_checks_link

  go_to_payments_page(@reg_number)
  expect(@bo.finance_payment_details_page).to have_enter_payment_button
  expect(@bo.finance_payment_details_page).to have_reverse_payment_button
  expect(@bo.finance_payment_details_page).to have_charge_adjust_button
  expect(@bo.finance_payment_details_page).to have_no_refund_button
  expect(@bo.finance_payment_details_page).to have_write_off_button

  # Permissions on pending registration
  visit_registration_details_page(@pending_reg_number)
  expect(@bo.registration_details_page).to have_no_cancel_link
end

Then(/^I have the correct permissions for a finance super user$/) do
  visit_registration_details_page(@reg_number)
  expect(@bo.registration_details_page).to have_no_renew_link
  expect(@bo.registration_details_page).to have_no_transfer_link
  expect(@bo.registration_details_page).to have_no_edit_link
  expect(@bo.registration_details_page).to have_view_certificate_link
  expect(@bo.registration_details_page).to have_no_order_cards_link
  expect(@bo.registration_details_page).to have_payment_details_link
  expect(@bo.registration_details_page).to have_no_cease_or_revoke_link
  expect(@bo.registration_details_page.govuk_banner).to have_manage_users_link
  expect(@bo.registration_details_page.govuk_banner).to have_no_conviction_checks_link

  go_to_payments_page(@reg_number)
  expect(@bo.finance_payment_details_page).to have_enter_payment_button
  expect(@bo.finance_payment_details_page).to have_reverse_payment_button
  expect(@bo.finance_payment_details_page).to have_charge_adjust_button
  expect(@bo.finance_payment_details_page).to have_no_refund_button
  expect(@bo.finance_payment_details_page).to have_write_off_button

  # Permissions on pending registration
  visit_registration_details_page(@pending_reg_number)
  expect(@bo.registration_details_page).to have_no_cancel_link
end
