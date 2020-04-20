def visit_registration_finance_details_page(reg_number)
  id = registration_id_for(reg_number)

  visit "#{Quke::Quke.config.custom["urls"]["back_office"]}/resources/#{id}/finance-details"
end

def visit_renewal_finance_details_page(reg_number)
  id = renewal_id_for(reg_number)

  visit "#{Quke::Quke.config.custom["urls"]["back_office"]}/resources/#{id}/finance-details"
end

def visit_registration_enter_payment_page(reg_number)
  id = renewal_id_for(reg_number)

  visit "#{Quke::Quke.config.custom["urls"]["back_office"]}/resources/#{id}/payments"
end

def visit_registration_refund_page(reg_number)
  id = renewal_id_for(reg_number)

  visit "#{Quke::Quke.config.custom["urls"]["back_office"]}/resources/#{id}/refunds"
end

def visit_registration_details_page(reg_identifier)
  visit("#{Quke::Quke.config.custom['urls']['back_office']}/registrations/#{reg_identifier}")
end

def visit_renewal_details_page(reg_identifier)
  visit("#{Quke::Quke.config.custom['urls']['back_office']}/renewing-registrations/#{reg_identifier}")
end
