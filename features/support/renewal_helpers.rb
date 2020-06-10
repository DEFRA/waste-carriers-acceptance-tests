# Steps specific to renewals

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
