def approve_conviction_immediately_for_reg(reg, company_name)
  check_conviction_matches_for(company_name)
  go_to_conviction_for_reg(reg)

  expected_info = "This registration may have matching or declared convictions and requires an initial review"
  expect(@bo.convictions_bo_details_page.info_panel).to have_text(expected_info)

  approve_conviction(reg)
end

def flag_conviction_for_reg(reg, company_name)
  check_conviction_matches_for(company_name)
  go_to_conviction_for_reg(reg)

  expected_info = "This registration may have matching or declared convictions and requires an initial review"
  expect(@bo.convictions_bo_details_page.info_panel).to have_text(expected_info)

  flag_conviction(reg, company_name)
end

def approve_flagged_conviction_for_reg(reg, company_name)
  check_in_progress_convictions_for(company_name)
  go_to_conviction_for_reg(reg)

  expected_info = "This registration has been reviewed and flagged as having relevant convictions."
  expect(@bo.convictions_bo_details_page.info_panel).to have_text(expected_info)

  approve_conviction(reg)
end

def reject_flagged_conviction_for_reg(reg, company_name)
  check_in_progress_convictions_for(company_name)
  go_to_conviction_for_reg(reg)

  expected_info = "This registration has been reviewed and flagged as having relevant convictions."
  expect(@bo.convictions_bo_details_page.info_panel).to have_text(expected_info)

  reject_conviction(reg)
end

def check_conviction_matches_for(text)
  sign_in_to_back_office("agency-refund-payment-user", false)
  @bo.dashboard_page.govuk_banner.conviction_checks_link.click
  @bo.convictions_dashboard_page.look_for_text(text)
  expect(@bo.convictions_dashboard_page.content).to have_text(text)
end

def check_in_progress_convictions_for(text)
  sign_in_to_back_office("agency-refund-payment-user", false)
  @bo.dashboard_page.govuk_banner.conviction_checks_link.click
  @bo.convictions_dashboard_page.in_progress_tab.click
  @bo.convictions_dashboard_page.look_for_text(text)
  expect(@bo.convictions_dashboard_page.content).to have_text(text)
end

def go_to_conviction_for_reg(reg)
  if @resource_object == :renewal
    # Because it is difficult to find a unique link to the registration's conviction checks, visit the URL directly:
    visit((Quke::Quke.config.custom["urls"]["back_office"]) + "/transient-registrations/" + reg + "/convictions")
  else # it's a registration
    visit((Quke::Quke.config.custom["urls"]["back_office"]) + "/registrations/" + reg + "/convictions")
  end
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
  expected_heading = if @resource_object == :renewal
                       "Approve a renewal with possible convictions: " + reg
                     else
                       "Approve a registration with possible convictions: " + reg
                     end
  expect(@bo.convictions_decision_page.heading).to have_text(expected_heading)
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
  expected_heading = if @resource_object == :renewal
                       "Reject a renewal with possible convictions: " + reg
                     else
                       "Reject a registration with possible convictions: " + reg
                     end
  expect(@bo.convictions_decision_page.heading).to have_text(expected_heading)
  @bo.convictions_decision_page.submit(conviction_reason: "Test conviction rejected")
  puts reg + " rejected due to convictions"
end

def dodgy_people
  [
    { first_name: "Jane", last_name: "Blogs", dob_day: 1, dob_month: 5, dob_year: 1984, position: "Smooth criminal" },
    { first_name: "Fred", last_name: "Blogs", dob_day: 1, dob_month: 5, dob_year: 1984, position: "Naughty person" },
    { first_name: "Alex", last_name: "Smith-Brown", dob_day: 1, dob_month: 5, dob_year: 1984, position: "The Don" }
  ]
end
