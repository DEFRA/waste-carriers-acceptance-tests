When("I turn all features off") do
  find_link("Toggle features").click
  @bo.toggle_features_page.add_all_toggles
  @bo.toggle_features_page.disable_all_features
end

Then("the features are no longer available") do
  # Look for resend renewal email link and magic link at bottom:
  visit_registration_details_page(@reg_number)
  expect(@bo.registration_details_page).to have_no_resend_renewal_email_link
  expect(@bo.registration_details_page).to have_no_text("Renewal link")

  # Go to new registration start page on frontend:
  visit("#{Quke::Quke.config.custom['urls']['front_office']}/start")
  expect(page).to have_text("Page not found").or have_text("No route matches")

  # Go to API page for registration:
  visit "#{Quke::Quke.config.custom['urls']['back_office']}/api/registrations/#{@reg_number}"
  expect(page).to have_text("Page not found").or have_text("No route matches")
end

When("I turn all features on") do
  visit("#{Quke::Quke.config.custom['urls']['back_office']}/features/feature-toggles")
  @bo.toggle_features_page.enable_all_features
end

Then("the features are available") do
  # Look for resend renewal email link and magic link at bottom:
  visit_registration_details_page(@reg_number)
  expect(@bo.registration_details_page).to have_resend_renewal_email_link
  expect(@bo.registration_details_page).to have_text("Renewal link")

  # Go to new registration start page on frontend:
  visit(Quke::Quke.config.custom["urls"]["front_office"])
  expect(page).to have_text("Is this a new registration?")

  # Go to API page for registration:
  visit "#{Quke::Quke.config.custom['urls']['back_office']}/api/registrations/#{@reg_number}"
  expect(page).to have_text("_id")
end
