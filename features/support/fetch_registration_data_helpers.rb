def fetch_registration_data_for(reg_identifier)
  # Sign in to back office unless already signed in
  sign_in_to_back_office("agency-refund-payment-user")

  visit "#{Quke::Quke.config.custom['urls']['back_office']}/api/registrations/#{reg_identifier}"

  @fetch_registration_data_cache = ApiResultPage.new.extract_data
  @fetch_registration_identifier_cache = reg_identifier
end

def registration_id_for(reg_identifier)
  fetch_registration_data_for(reg_identifier) unless reg_identifier == @fetch_registration_identifier_cache

  @fetch_registration_data_cache["_id"]
end

def renew_token_for(reg_identifier)
  # Find the token to include in the email renewal link.
  # This requires the token to have been generated, which is done by clicking "Resend renewal email" on back office
  send_renewal_email(reg_identifier)
  fetch_registration_data_for(reg_identifier) unless reg_identifier == @fetch_registration_identifier_cache

  @fetch_registration_data_cache["renew_token"]
end

def fetch_renewal_data_for(reg_identifier)
  # Sign in to back office unless already signed in
  sign_in_to_back_office("agency-refund-payment-user")

  visit "#{Quke::Quke.config.custom['urls']['back_office']}/api/renewals/#{reg_identifier}"

  @fetch_renewal_data_cache = ApiResultPage.new.extract_data
  @fetch_renewal_identifier_cache = reg_identifier
end

def renewal_id_for(reg_identifier)
  fetch_renewal_data_for(reg_identifier) unless reg_identifier == @fetch_renewal_identifier_cache

  @fetch_renewal_data_cache["_id"]
end
