def approve_conviction_immediately_for_reg(reg, company_name)
  go_to_conviction_dashboard
  expect(@bo.convictions_dashboard_page.content).to have_text(company_name)

  go_to_conviction_for_reg(reg)

  expected_info = "This registration may have matching or declared convictions and requires an initial review"
  expect(@bo.convictions_bo_details_page.info_panel).to have_text(expected_info)

  approve_conviction(reg)
end

def flag_conviction_for_reg(reg, company_name)
  go_to_conviction_dashboard
  expect(@bo.convictions_dashboard_page.content).to have_text(company_name)

  go_to_conviction_for_reg(reg)

  expected_info = "This registration may have matching or declared convictions and requires an initial review"
  expect(@bo.convictions_bo_details_page.info_panel).to have_text(expected_info)

  flag_conviction(reg, company_name)
end

def approve_flagged_conviction_for_reg(reg, company_name)
  go_to_conviction_dashboard
  @bo.convictions_dashboard_page.in_progress_tab.click
  expect(@bo.convictions_dashboard_page.content).to have_text(company_name)

  go_to_conviction_for_reg(reg)

  expected_info = "This registration has been reviewed and flagged as having relevant convictions."
  expect(@bo.convictions_bo_details_page.info_panel).to have_text(expected_info)

  approve_conviction(reg)
end

def reject_flagged_conviction_for_reg(reg, company_name)
  go_to_conviction_dashboard
  @bo.convictions_dashboard_page.in_progress_tab.click
  expect(@bo.convictions_dashboard_page.content).to have_text(company_name)

  go_to_conviction_for_reg(reg)

  expected_info = "This registration has been reviewed and flagged as having relevant convictions."
  expect(@bo.convictions_bo_details_page.info_panel).to have_text(expected_info)

  reject_conviction(reg)
end

def go_to_conviction_dashboard
  sign_in_to_back_office("agency_user")
  @bo.dashboard_page.govuk_banner.conviction_checks.click
end

def go_to_conviction_for_reg(reg)
  # Because it is difficult to find a unique link to the registration's conviction checks, visit the URL directly:
  visit((Quke::Quke.config.custom["urls"]["back_office_renewals"]) + "/bo/registrations/" + reg + "/convictions")
  expect(@bo.convictions_bo_details_page.heading).to have_text("Conviction information for " + reg)

  # Registration sample URL:
  # https://admin-waste-carriers-tst.aws.defra.cloud/bo/registrations/CBDU8/convictions
  # Renewal sample URL:
  # https://admin-waste-carriers-tst.aws.defra.cloud/bo/transient-registrations/CBDU2/convictions

  # Possible text:
  # This registration may have matching or declared conviction and requires an initial review.
  # This registration has been reviewed and flagged as having relevant convictions.
  # This registration was approved after a review of the matching or declared convictions.
end

def approve_conviction(reg)
  @bo.convictions_bo_details_page.approve_button.click
  expect(@bo.convictions_decision_page.heading).to have_text("Approve a registration with possible convictions: " + reg)
  @bo.convictions_decision_page.submit(conviction_reason: "Test conviction approved")
  puts reg + " approved following conviction check"
end

def flag_conviction(reg, company_name)
  @bo.convictions_bo_details_page.flag_button.click
  # No confirmation given when flagging a conviction
  @bo.convictions_dashboard_page.in_progress_tab.click
  expect(@bo.convictions_dashboard_page.heading).to have_text("Convictions checks in progress")
  expect(@bo.convictions_dashboard_page.content).to have_text(reg)
  expect(@bo.convictions_dashboard_page.content).to have_text(company_name)
end

def reject_conviction(reg)
  @bo.convictions_bo_details_page.reject_button.click
  expect(@bo.convictions_decision_page.heading).to have_text("Reject a registration with possible convictions: " + reg)
  @bo.convictions_decision_page.submit(conviction_reason: "Test conviction rejected")
  puts reg + " rejected due to convictions"
end
