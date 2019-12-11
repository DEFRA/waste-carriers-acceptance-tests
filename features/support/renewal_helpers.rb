# Steps specific to renewals

def start_internal_renewal
  # BUG:
  # The following clause is necessary because the AD privacy policy is bypassed when renewing from the new app.
  @bo.ad_privacy_policy_page.submit unless @app == "new"
  expect(@bo.renewal_start_page.heading).to have_text("You are about to renew")
  agree_to_renew_in_england
end

# Reused across several steps
def agree_to_renew_in_england
  @bo.renewal_start_page.submit
  @bo.location_page.submit(choice: :england_new)
end
