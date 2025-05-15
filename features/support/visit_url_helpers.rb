def visit_charge_adjust_page(reg_number)
  id = @reg_type == :renewal ? renewal_id_for(reg_number) : registration_id_for(reg_number)

  visit "#{Quke::Quke.config.custom['urls']['back_office']}/resources/#{id}/payments/charge-adjusts"
end

def visit_reverse_payment_page(reg_number)
  id = @reg_type == :renewal ? renewal_id_for(reg_number) : registration_id_for(reg_number)

  visit "#{Quke::Quke.config.custom['urls']['back_office']}/resources/#{id}/reversals"
end

def visit_finance_details_page(reg_number)
  id = @reg_type == :renewal ? renewal_id_for(reg_number) : registration_id_for(reg_number)

  visit "#{Quke::Quke.config.custom['urls']['back_office']}/resources/#{id}/finance-details"
end

def visit_enter_payment_page(reg_number)
  id = @reg_type == :renewal ? renewal_id_for(reg_number) : registration_id_for(reg_number)

  visit "#{Quke::Quke.config.custom['urls']['back_office']}/resources/#{id}/payments"
end

def visit_refund_page(reg_number)
  id = @reg_type == :renewal ? renewal_id_for(reg_number) : registration_id_for(reg_number)

  visit "#{Quke::Quke.config.custom['urls']['back_office']}/resources/#{id}/refunds"
end

def visit_registration_details_page(reg_identifier)
  visit("#{Quke::Quke.config.custom['urls']['back_office']}/registrations/#{reg_identifier}")
end

def visit_renewal_details_page(reg_identifier)
  visit("#{Quke::Quke.config.custom['urls']['back_office']}/renewing-registrations/#{reg_identifier}")
end

def renewal_magic_link_for(reg_identifier)
  "#{Quke::Quke.config.custom['urls']['front_office']}/fo/renew/#{renew_token_for(reg_identifier)}"
end

def visit_renewal_magic_link(reg_identifier)
  visit(renewal_magic_link_for(reg_identifier))
end

def visit_govPay_mock_payment_status_page(status)
  puts "#{Quke::Quke.config.custom['urls']['back_office']}/mocks/govpay/v1/payments/set_test_payment_response_status/#{status}"
  visit("#{Quke::Quke.config.custom['urls']['back_office']}/mocks/govpay/v1/payments/set_test_payment_response_status/#{status}")
end

def visit_govPay_mock_refund_status_page(status)
  puts "#{Quke::Quke.config.custom['urls']['back_office']}/mocks/govpay/v1/payments/set_test_refund_response_status/#{status}"
  visit("#{Quke::Quke.config.custom['urls']['back_office']}/mocks/govpay/v1/payments/set_test_refund_response_status/#{status}")
end