Given(/^I have signed into the renewals service as an agency user$/) do
  @bo = BackOfficeApp.new
  @journey = JourneyApp.new
  @bo.sign_in_page.load
  @bo.sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency_user"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Given(/^I have signed into the renewals service as an agency user with refunds$/) do
  @bo = BackOfficeApp.new
  @journey = JourneyApp.new
  @bo.sign_in_page.load
  @bo.sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency_user_with_payment_refund"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Given(/^there is an existing registration$/) do
  # No action, this just exists to make the feature look nicer
end

Given(/^NCCC partially renews an existing registration with "([^"]*)"$/) do |convictions|

  # Set variables that can be reused across steps.
  @app = "new"
  @convictions = convictions

  # Search for registration to renew:
  sign_in_to_back_office
  @bo.dashboard_page.view_reg_details(search_term: @registration_number)
  @bo.view_details_page.renew_link.click
  start_internal_renewal

  # Submit carrier details for the business, tier and carrier:
  submit_carrier_details("existing", "existing", "existing")
  expect(@bo.renewal_information_page).to have_text("you still need an upper tier registration")
  @bo.renewal_information_page.submit

  @business_name = submit_business_details
  submit_company_people
  submit_convictions(convictions)
  submit_contact_details_from_bo
  check_your_answers

end

Given(/^the back office pages show the correct transient renewal details$/) do
  sign_in_to_back_office
  @bo.dashboard_page.view_transient_reg_details(search_term: @registration_number)

  expect(@bo.view_details_page.heading).to have_text("Renewal " + @registration_number)
  expect(@bo.view_details_page).to have_text "Application in progress"
  expect(@bo.view_details_page).to have_continue_as_ad_button
  expect(@bo.view_details_page.info_panel).to have_text(@business_name)
  expect(@bo.view_details_page.content).to have_text("Bob Carolgees")
  expect(@bo.view_details_page.content).to have_text("Application still in progress. No finance data yet.")

  if @convictions == "no convictions"
    expect(@bo.view_details_page.content).to have_text("There are no convictions for this registration")
  end

end

Given(/^NCCC goes back to the in progress renewal$/) do
  @bo.view_details_page.continue_as_ad_button.click
end

Then(/^the renewal is complete$/) do
  expect(@renewals_app.renewal_complete_page.heading).to have_text("Renewal complete")
  # rubocop:disable Metrics/LineLength
  expect(@renewals_app.renewal_complete_page.confirmation_box).to have_text("Your registration number is still\n" + @registration_number)
  # rubocop:enable Metrics/LineLength
  puts "Renewal " + @registration_number + " complete"
end

Given(/^I choose to renew "([^"]*)"$/) do |reg|
  @registration_number = reg
  @back_app.registrations_page.search(search_input: @registration_number)
  @expiry_date = @back_app.registrations_page.search_results[0].expiry_date.text
  # Turns the text expiry date into a date
  @expiry_date_year_first = Date.parse(@expiry_date)
  @back_app.registrations_page.search_results[0].renew.click
end

When(/^I renew the local authority registration$/) do
  start_internal_renewal
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :skip_check)
  @journey.carrier_type_page.submit
  @bo.renewal_information_page.submit
  submit_business_details
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
  @bo.registration_cards_page.submit
  @bo.payment_summary_page.submit(choice: :card_payment)

  submit_valid_card_payment

end

When(/^I renew the limited company registration$/) do
  start_internal_renewal
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :check_tier)
  @bo.other_businesses_page.submit(choice: :no)
  @bo.construction_waste_page.submit(choice: :yes)
  @journey.carrier_type_page.submit
  @bo.renewal_information_page.submit
  submit_business_details
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
  @bo.registration_cards_page.submit
  @bo.payment_summary_page.submit(choice: :card_payment)

  submit_valid_card_payment

end

Given(/^"([^"]*)" has been partially renewed by the account holder$/) do |reg|
  # save registration number for checks later on
  @registration_number = reg
  @front_app = FrontOfficeApp.new
  @renewals_app = RenewalsApp.new
  @journey = JourneyApp.new
  @front_app.start_page.load
  @front_app.start_page.submit(renewal: true)
  @front_app.existing_registration_page.submit(reg_no: @registration_number)
  @front_app.waste_carrier_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["waste_carrier"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  agree_to_renew_in_england

  Capybara.reset_session!
end

When(/^I complete the renewal "([^"]*)" for the account holder$/) do |reg|
  @bo.dashboard_page.submit(search_term: reg)
  @bo.dashboard_page.results[0].actions.click
  find_link("Resume application").click
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :skip_check)
  @journey.carrier_type_page.submit
  @bo.renewal_information_page.submit
  submit_business_details
  submit_company_people
  submit_convictions("no convictions")
  @journey.contact_name_page.submit
  @journey.contact_phone_page.submit
  @journey.contact_email_page.submit
  @journey.address_lookup_page.submit_valid_address
  check_your_answers
  @bo.registration_cards_page.submit
  @bo.payment_summary_page.submit(choice: :card_payment)

  submit_valid_card_payment

end

Given(/^an Environment Agency user has signed in to complete a renewal$/) do
  @back_app = BackEndApp.new
  @bo = BackOfficeApp.new
  @journey = JourneyApp.new
  @back_app.agency_sign_in_page.load
  @back_app.agency_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency_user"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Given(/^an Agency super user has signed in to the admin area$/) do
  @back_app = BackEndApp.new
  @bo = BackOfficeApp.new
  @journey = JourneyApp.new
  @back_app.admin_sign_in_page.load
  @back_app.admin_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency_super"]["username"],
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

When(/^an Agency super user has signed into the back office$/) do
  @bo.sign_in_page.load
  @bo.sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency_super"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

When(/^migrates the backend users to the back office$/) do
  @bo.dashboard_page.govuk_banner.manage_users.click
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
  @bo.dashboard_page.submit(search_term: reg.to_sym)
  # saves registration for later use
  @registration_number = reg
end

When(/^I mark the renewal payment as received$/) do
  @bo.dashboard_page.results[0].actions.click
  @bo.transient_registrations_page.process_payment.click
  @bo.renewal_payments_page.submit(choice: :cash)
  @bo.cash_payment_page.submit(
    amount: "105",
    day: "01",
    month: "01",
    year: "1980",
    reference: "0101010",
    comment: "cash money"
  )
end

Then(/^the registration will have a "([^"]*)" status$/) do |status|
  @bo.dashboard_page.govuk_banner.home_page.click
  @bo.dashboard_page.submit(search_term: @registration_number)
  expect(@bo.dashboard_page.results_table).to have_text(status)
end

Then(/^the expiry date should be three years from the previous expiry date$/) do
  # Adds three years to expiry date and then checks expiry date reported in registration details
  @expected_expiry_date = @expiry_date_year_first.next_year(3)
  visit(Quke::Quke.config.custom["urls"]["back_office"])
  @bo.registrations_page.search(search_input: @registration_number)
  actual_expiry_date = Date.parse(@bo.registrations_page.search_results[0].expiry_date.text)
  expect(@expected_expiry_date).to eq(actual_expiry_date)
end

Given(/^I renew the limited company registration declaring a conviction and paying by bank transfer$/) do
  start_internal_renewal
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :check_tier)
  @bo.other_businesses_page.submit(choice: :no)
  @bo.construction_waste_page.submit(choice: :yes)
  @journey.carrier_type_page.submit
  @bo.renewal_information_page.submit
  submit_business_details
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
  @bo.registration_cards_page.submit
  @bo.payment_summary_page.submit(choice: :bank_transfer_payment)
  @bo.bank_transfer_page.submit
  @bo.dashboard_page.govuk_banner.home_page.click
end

When(/^I approve the conviction check$/) do
  @bo.dashboard_page.govuk_banner.conviction_checks.click
  # rubocop:disable Metrics/LineLength
  visit((Quke::Quke.config.custom["urls"]["back_office_renewals"]) + "/bo/transient-registrations/#{@registration_number}/convictions")
  # rubocop:enable Metrics/LineLength

  @bo.convictions_page.approve.click
  @bo.approve_convictions_page.submit(approval_reason: "ok")
end
