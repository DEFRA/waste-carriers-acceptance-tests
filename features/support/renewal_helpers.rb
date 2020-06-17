# Steps specific to renewals

def send_renewal_email(reg_identifier)
  sign_in_to_back_office("agency-user", false)
  visit_registration_details_page(reg_identifier)
  @bo.registration_details_page.resend_renewal_email_link.click
end

def start_internal_renewal
  @bo.ad_privacy_policy_page.submit
  expect(@renewals_app.renewal_start_page.heading).to have_text("You are about to renew")
  agree_to_renew_in_england
end

def agree_to_renew_in_england
  @renewals_app.renewal_start_page.submit
  @journey.location_page.submit(choice: :england)
end

def submit_existing_contact_details
  @journey.contact_name_page.submit
  @journey.contact_phone_page.submit
  @journey.contact_email_page.submit
  complete_address_with_random_method
end
