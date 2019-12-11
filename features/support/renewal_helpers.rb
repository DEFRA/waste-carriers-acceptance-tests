# Steps specific to renewals

def start_internal_renewal
  @bo.ad_privacy_policy_page.submit
  expect(@renewals_app.renewal_start_page.heading).to have_text("You are about to renew")
  agree_to_renew_in_england
end

# Reused across several steps
def agree_to_renew_in_england
  @renewals_app.renewal_start_page.submit
  @renewals_app.location_page.submit(choice: :england_new)
end
