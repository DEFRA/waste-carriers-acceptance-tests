# Steps specific to renewals

def send_renewal_email(reg_identifier)
  sign_in_to_back_office("agency-user", false)
  visit_registration_details_page(reg_identifier)
  @bo.registration_details_page.wait_until_resend_renewal_email_link_visible
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
