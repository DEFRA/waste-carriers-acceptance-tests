Given(/^there is an existing registration$/) do
  # No action, this just exists to make the feature look nicer
end

Given(/^NCCC partially renews an existing registration with "([^"]*)"$/) do |convictions|

  # Set variables that can be reused across steps.
  @app = "new"
  @tier = "upper"
  @convictions = convictions
  @business_name = "AD Renewal with " + @convictions
  @is_renewal = true
  @is_transient_renewal = true

  # Search for registration to renew:
  sign_in_to_back_office("agency-user")
  @bo.dashboard_page.view_reg_details(search_term: @reg_number)
  @bo.registration_details_page.renew_link.click
  start_internal_renewal

  # Submit carrier details for the business, tier and carrier:
  submit_carrier_details("existing", "existing", "existing")
  expect(@bo.renewal_information_page).to have_text("you still need an upper tier registration")
  @bo.renewal_information_page.submit

  submit_business_details(@business_name)
  submit_company_people
  submit_convictions(convictions)
  submit_contact_details_from_bo
  check_your_answers
  # User has submitted the declaration and is on the "certificate and registration cards" page
end

Given(/^the back office pages show the correct transient renewal details$/) do
  sign_in_to_back_office("agency-user")
  @bo.dashboard_page.view_transient_reg_details(search_term: @reg_number)

  expect(@bo.registration_details_page.heading).to have_text("Renewal " + @reg_number)
  expect(@bo.registration_details_page).to have_text "Application in progress"
  expect(@bo.registration_details_page).to have_continue_as_ad_button
  expect(@bo.registration_details_page.info_panel).to have_text(@business_name)
  expect(@bo.registration_details_page.content).to have_text("Bob Carolgees")
  expect(@bo.registration_details_page.content).to have_text("Application still in progress. No finance data yet.")
  expect(@bo.registration_details_page).to have_no_view_certificate_link

  if @convictions == "no convictions"
    expect(@bo.registration_details_page.content).to have_text("There are no convictions for this registration")
  end

end

Given(/^NCCC goes back to the in progress renewal$/) do
  @bo.registration_details_page.continue_as_ad_button.click
  @bo.ad_privacy_policy_page.submit
end

Then(/^the renewal is complete$/) do
  expect(@renewals_app.renewal_complete_page.heading).to have_text("Renewal complete")
  expect(@renewals_app.renewal_complete_page.confirmation_box).to have_text("Your registration number is still\n" + @reg_number)
  puts "Renewal " + @reg_number + " complete"

  @renewals_app.renewal_complete_page.finished_button.click
  expect(@bo.registration_details_page.heading).to have_text("Registration " + @reg_number)
end

Given(/^I choose to renew "([^"]*)"$/) do |reg|
  @reg_number = reg

  @back_app.registrations_page.search(search_input: @reg_number)
  @expiry_date = @back_app.registrations_page.search_results[0].expiry_date.text
  # Turns the text expiry date into a date
  @expiry_date_year_first = Date.parse(@expiry_date)
end

When(/^I renew the local authority registration$/) do
  @business_name = "Local authority renewal"
  @bo.dashboard_page.view_reg_details(search_term: @reg_number)
  @bo.registration_details_page.renew_link.click
  start_internal_renewal
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :skip_check)
  @journey.carrier_type_page.submit
  @bo.renewal_information_page.submit
  submit_business_details(@business_name)
  submit_company_people
  submit_convictions("no convictions")
  @journey.contact_name_page.submit
  @journey.contact_phone_page.submit
  @journey.contact_email_page.submit(
    email: "bo-user@example.com",
    confirm_email: "bo-user@example.com"
  )
  @journey.address_lookup_page.submit_valid_address
  check_your_answers
  @journey.registration_cards_page.submit
  @bo.payment_summary_page.submit(choice: :card_payment)

  submit_valid_card_payment

end

When(/^I renew the limited company registration$/) do
  @business_name = "Limited company renewal"
  @bo.dashboard_page.view_reg_details(search_term: @reg_number)
  @bo.registration_details_page.renew_link.click
  start_internal_renewal
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :check_tier)
  select_upper_tier_options("existing")
  @bo.renewal_information_page.submit
  submit_business_details(@business_name)
  submit_company_people
  submit_convictions("no convictions")
  @journey.contact_name_page.submit
  @journey.contact_phone_page.submit
  @journey.contact_email_page.submit(
    email: "bo-user@example.com",
    confirm_email: "bo-user@example.com"
  )
  @journey.address_lookup_page.submit_invalid_address
  @journey.address_manual_page.submit(
    house_number: "1",
    address_line_one: "Test lane",
    address_line_two: "Testville",
    city: "Teston"
  )
  check_your_answers
  @journey.registration_cards_page.submit
  @bo.payment_summary_page.submit(choice: :card_payment)

  submit_valid_card_payment

end

Given(/^"([^"]*)" has been partially renewed by the account holder$/) do |reg|
  # save registration number for checks later on
  @reg_number = reg
  @front_app = FrontOfficeApp.new
  @renewals_app = RenewalsApp.new
  @journey = JourneyApp.new
  @front_app.start_page.load
  @front_app.start_page.submit(renewal: true)
  @front_app.existing_registration_page.submit(reg_no: @reg_number)
  @front_app.waste_carrier_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["waste_carrier"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  agree_to_renew_in_england

  Capybara.reset_session!
end

When(/^I complete the renewal "([^"]*)" for the account holder$/) do |reg|
  @business_name = "Assisted digital resumed renewal"
  @bo.dashboard_page.view_transient_reg_details(search_term: reg)
  @bo.registration_details_page.continue_as_ad_button.click
  @bo.ad_privacy_policy_page.submit
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :skip_check)
  @journey.carrier_type_page.submit
  @bo.renewal_information_page.submit
  submit_business_details(@business_name)
  submit_company_people
  submit_convictions("no convictions")
  @journey.contact_name_page.submit
  @journey.contact_phone_page.submit
  @journey.contact_email_page.submit
  @journey.address_lookup_page.submit_valid_address
  check_your_answers
  @journey.registration_cards_page.submit
  @bo.payment_summary_page.submit(choice: :card_payment)

  submit_valid_card_payment

end

Given(/^an Agency super user has signed in to the admin area$/) do
  @back_app = BackEndApp.new
  @bo = BackOfficeApp.new
  @journey = JourneyApp.new
  @back_app.admin_sign_in_page.load
  @back_app.admin_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency-super"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Given(/^has created an agency user for "([^"]*)"$/) do |user|
  @back_app.agency_users_page.add_user.click
  @back_app.agency_users_page.submit(
    email: user,
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  @user = user
  expect(@back_app.agency_users_page).to have_text("Agency user was successfully created.")
  @back_app.agency_users_page.sign_out.click
end

When(/^migrates the backend users to the back office$/) do
  @bo.dashboard_page.govuk_banner.manage_users_link.click
  expect(@bo.users_page).to_not have_text(@user)
  @bo.users_page.migrate_users.click
  @bo.migrate_page.migrate_users.click
  expect(@bo.migrate_page).to have_text(@user)
end

Then(/^the user has been added to the back office$/) do
  expect(@bo.migrate_page).to have_text(@user)
end

When(/^I search for "([^"]*)" pending payment$/) do |reg|
  @bo.dashboard_page.govuk_banner.home_page.click
  @bo.dashboard_page.view_transient_reg_details(search_term: reg)
  # saves registration for later use
  @reg_number = reg
end

When(/^I mark the renewal payment as received$/) do
  @bo.registration_details_page.process_payment_button.click
  pay_by_cash(105)
  @is_transient_renewal = false
end

Then(/^the expiry date should be three years from the previous expiry date$/) do
  # Adds three years to expiry date and then checks expiry date reported in registration details.
  # Need to convert this step to new app!
  @expected_expiry_date = @expiry_date_year_first.next_year(3)
  visit(Quke::Quke.config.custom["urls"]["back_office"])
  @back_app.registrations_page.search(search_input: @reg_number)
  actual_expiry_date = Date.parse(@back_app.registrations_page.search_results[0].expiry_date.text)
  expect(@expected_expiry_date).to eq(actual_expiry_date)
end

Given(/^I renew the limited company registration declaring a conviction and paying by bank transfer$/) do
  @business_name = "Renewal with conviction via bank transfer"
  @bo.dashboard_page.view_reg_details(search_term: @reg_number)
  @bo.registration_details_page.renew_link.click
  start_internal_renewal
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :check_tier)
  select_upper_tier_options("existing")
  @bo.renewal_information_page.submit
  submit_business_details(@business_name)
  submit_company_people
  submit_convictions("convictions")
  @journey.contact_name_page.submit
  @journey.contact_phone_page.submit
  @journey.contact_email_page.submit(
    email: "bo-user@example.com",
    confirm_email: "bo-user@example.com"
  )
  @journey.address_lookup_page.submit_valid_address
  check_your_answers
  @journey.registration_cards_page.submit
  @bo.payment_summary_page.submit(choice: :bank_transfer_payment)
  @bo.bank_transfer_page.submit
  @bo.dashboard_page.govuk_banner.home_page.click
end

When(/^I approve the conviction check$/) do
  @bo.dashboard_page.govuk_banner.conviction_checks_link.click
  visit((Quke::Quke.config.custom["urls"]["back_office_renewals"]) + "/bo/transient-registrations/#{@reg_number}/convictions")

  @bo.convictions_bo_details_page.approve_button.click
  @bo.convictions_decision_page.submit(conviction_reason: "ok")
end
