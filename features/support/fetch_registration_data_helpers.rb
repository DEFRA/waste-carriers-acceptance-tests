# Used for caching
@@reg_identifier = nil
@@data = nil

def registration_id_for(reg_identifier)
  fetch_registration_data_for(reg_identifier) unless reg_identifier == @@reg_identifier

  @@data["_id"]
end

def renewal_id_for(reg_identifier)
  fetch_renewal_data_for(reg_identifier) unless reg_identifier == @@reg_identifier

  @@data["_id"]
end

def fetch_registration_data_for(reg_identifier)
  # Sign in to back office unless already signed in
  sign_in_to_back_office("agency-refund-payment-user", false)

  visit "#{Quke::Quke.config.custom["urls"]["back_office"]}/api/registrations/#{reg_identifier}"

  @@data = ApiResultPage.new.extract_data
  @@reg_identifier = reg_identifier
end

def fetch_renewal_data_for(reg_identifier)
  # Sign in to back office unless already signed in
  sign_in_to_back_office("agency-refund-payment-user", false)

  visit "#{Quke::Quke.config.custom["urls"]["back_office"]}/api/renewals/#{reg_identifier}"

  @@data = ApiResultPage.new.extract_data
  @@reg_identifier = reg_identifier
end
