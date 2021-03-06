# Steps specific to renewals

def send_renewal_email(reg_identifier)
  sign_in_to_back_office("agency-user", false)
  visit_registration_details_page(reg_identifier)
  @bo.registration_details_page.wait_until_resend_renewal_email_link_visible
  @bo.registration_details_page.resend_renewal_email_link.click
end

def start_internal_renewal
  @bo.ad_privacy_policy_page.submit
  expect(@journey.renewal_start_page.heading).to have_text("You are about to renew")
  agree_to_renew_in_england
end

def agree_to_renew_in_england
  @journey.renewal_start_page.submit
  @journey.location_page.submit(choice: :england)
end

def submit_existing_renewal_details
  # Covers a standard renewal journey after "agree_to_renew_in_england" up to and including "check your answers":

  # Submit carrier details for the business, tier and carrier:
  submit_carrier_details("existing", "existing", "existing")
  expect(@journey.renewal_information_page).to have_text("you still need an upper tier registration")
  @journey.renewal_information_page.submit
  submit_business_details(@business_name, @tier)
  submit_company_people
  submit_convictions(@convictions)
  submit_contact_details_for_renewal
  check_your_answers

  # User has submitted the declaration and is on the "certificate and registration cards" page
end

def expiry_date_from_reg_details
  # Gets the expiry date (in format "31 December 2020") from the registration details page
  # and converts it into YYYY-MM-DD format.

  expiry_date = page.text.match(/.*Expires: (.*)\n.*/)[1]
  Date.parse(expiry_date)
end
