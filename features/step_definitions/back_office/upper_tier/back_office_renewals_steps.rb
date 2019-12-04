Given(/^I have signed into the renewals service as an agency user$/) do
  @bo = BackOfficeApp.new
  @journey_app = JourneyApp.new
  @bo.sign_in_page.load
  @bo.sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency_user"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Given(/^I have signed into the renewals service as an agency user with refunds$/) do
  @bo = BackOfficeApp.new
  @journey_app = JourneyApp.new
  @bo.sign_in_page.load
  @bo.sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency_user_with_payment_refund"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Given(/^I choose to renew "([^"]*)"$/) do |reg|
  @registration_number = reg
  @bo.registrations_page.search(search_input: @registration_number)
  @expiry_date = @bo.registrations_page.search_results[0].expiry_date.text
  # Turns the text expiry date into a date
  @expiry_date_year_first = Date.parse(@expiry_date)
  @bo.registrations_page.search_results[0].renew.click
end

When(/^I renew the local authority registration$/) do
  @bo.ad_privacy_policy_page.submit
  expect(@bo.renewal_start_page.heading).to have_text("You are about to renew")
  @bo.renewal_start_page.submit
  @bo.location_page.submit(choice: :england_new)
  @bo.confirm_business_type_page.submit
  @bo.tier_check_page.submit(choice: :skip_check)
  @bo.carrier_type_page.submit
  @bo.renewal_information_page.submit
  @bo.company_name_page.submit
  @journey_app.address_lookup_page.submit_valid_address
  people = @bo.main_people_page.main_people
  @bo.main_people_page.add_main_person(person: people[0])
  @bo.main_people_page.submit_main_person(person: people[1])
  @bo.declare_convictions_page.submit(choice: :no)
  @bo.contact_name_page.submit
  @bo.contact_telephone_number_page.submit
  @bo.contact_email_page.submit(
    email: "bo-user@example.com",
    confirm_email: "bo-user@example.com"
  )
  @journey_app.address_lookup_page.submit_valid_address
  @bo.check_your_answers_page.submit
  @bo.declaration_page.submit
  @bo.registration_cards_page.submit
  @bo.payment_summary_page.submit(choice: :card_payment)

  submit_valid_card_payment

end

When(/^I renew the limited company registration$/) do
  @bo.ad_privacy_policy_page.submit
  @bo.renewal_start_page.submit
  @bo.location_page.submit(choice: :england_new)
  @bo.confirm_business_type_page.submit
  @bo.tier_check_page.submit(choice: :check_tier)
  @bo.other_businesses_page.submit(choice: :no)
  @bo.construction_waste_page.submit(choice: :yes)
  @bo.carrier_type_page.submit
  @bo.renewal_information_page.submit
  @bo.registration_number_page.submit
  @bo.company_name_page.submit
  @journey_app.address_lookup_page.choose_manual_address
  @journey_app.address_manual_page.submit(
    house_number: "1",
    address_line_one: "Test lane",
    address_line_two: "Testville",
    city: "Teston"
  )
  people = @bo.main_people_page.main_people
  @bo.main_people_page.add_main_person(person: people[0])
  @bo.main_people_page.add_main_person(person: people[1])
  @bo.main_people_page.submit_main_person(person: people[2])
  @bo.declare_convictions_page.submit(choice: :no)
  @bo.contact_name_page.submit
  @bo.contact_telephone_number_page.submit
  @bo.contact_email_page.submit(
    email: "bo-user@example.com",
    confirm_email: "bo-user@example.com"
  )
  @journey_app.address_lookup_page.submit_invalid_address
  @journey_app.address_manual_page.submit(
    house_number: "1",
    address_line_one: "Test lane",
    address_line_two: "Testville",
    city: "Teston"
  )
  @bo.check_your_answers_page.submit
  @bo.declaration_page.submit
  @bo.registration_cards_page.submit
  @bo.payment_summary_page.submit(choice: :card_payment)

  submit_valid_card_payment

end

Given(/^"([^"]*)" has been partially renewed by the account holder$/) do |reg|
  # save registration number for checks later on
  @registration_number = reg
  @bo = RenewalsApp.new
  @journey_app = JourneyApp.new
  @bo.start_page.load
  @bo.start_page.submit(renewal: true)
  @bo.existing_registration_page.submit(reg_no: @registration_number)
  @bo.waste_carrier_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["waste_carrier"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  @bo.renewal_start_page.submit
  @bo.location_page.submit(choice: :england_new)

  Capybara.reset_session!
end

When(/^I complete the renewal "([^"]*)" for the account holder$/) do |reg|
  @bo.renewals_dashboard_page.submit(search_term: reg)
  @bo.renewals_dashboard_page.results[0].actions.click
  find_link("Resume application").click
  @bo.confirm_business_type_page.submit
  @bo.tier_check_page.submit(choice: :skip_check)
  @bo.carrier_type_page.submit
  @bo.renewal_information_page.submit
  @bo.company_name_page.submit
  @journey_app.address_lookup_page.submit_valid_address
  people = @bo.main_people_page.main_people
  @bo.main_people_page.add_main_person(person: people[0])
  @bo.main_people_page.submit_main_person(person: people[1])
  @bo.declare_convictions_page.submit(choice: :no)
  @bo.contact_name_page.submit
  @bo.contact_telephone_number_page.submit
  @bo.contact_email_page.submit
  @journey_app.address_lookup_page.submit_valid_address
  @bo.check_your_answers_page.submit
  @bo.declaration_page.submit
  @bo.registration_cards_page.submit
  @bo.payment_summary_page.submit(choice: :card_payment)

  submit_valid_card_payment

end

Then(/^the registration will have been renewed$/) do
  expect(@bo.finish_assisted_page).to have_text(@registration_number)
  expect(@bo.finish_assisted_page).to have_text("Renewal complete")
end

Given(/^an Environment Agency user has signed in to complete a renewal$/) do
  @bo = BackOfficeApp.new
  @journey_app = JourneyApp.new
  @bo.agency_sign_in_page.load
  @bo.agency_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency_user"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Given(/^an Agency super user has signed in to the admin area$/) do
  @bo = BackOfficeApp.new
  @journey_app = JourneyApp.new
  @bo.admin_sign_in_page.load
  @bo.admin_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency_super"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Given(/^has created an agency user for "([^"]*)"$/) do |user|
  @bo.agency_users_page.add_user.click
  @bo.agency_users_page.submit(
    email: user,
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  @user = user
  expect(@bo.agency_users_page).to have_text("Agency user was successfully created.")
  @bo.agency_users_page.sign_out.click
end

When(/^an Agency super user has signed into the back office$/) do
  @bo.sign_in_page.load
  @bo.sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency_super"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

When(/^migrates the backend users to the back office$/) do
  @bo.renewals_dashboard_page.govuk_banner.manage_users.click
  expect(@bo.users_page).to_not have_text(@user)
  @bo.users_page.migrate_users.click
  @bo.migrate_page.migrate_users.click
  expect(@bo.migrate_page).to have_text(@user)
end

Then(/^the user has been added to the back office$/) do
  expect(@bo.migrate_page).to have_text(@user)
end

When(/^I search for "([^"]*)" pending payment$/) do |reg|
  @bo.renewals_dashboard_page.govuk_banner.home_page.click
  @bo.renewals_dashboard_page.submit(search_term: reg.to_sym)
  # saves registration for later use
  @reg = reg
end

When(/^I mark the renewal payment as received$/) do
  @bo.renewals_dashboard_page.results[0].actions.click
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
  @bo.renewals_dashboard_page.govuk_banner.home_page.click
  @bo.renewals_dashboard_page.submit(search_term: @reg)
  expect(@bo.renewals_dashboard_page.results_table).to have_text(status)
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
  @bo.ad_privacy_policy_page.submit
  @bo.renewal_start_page.submit
  @bo.location_page.submit(choice: :england_new)
  @bo.confirm_business_type_page.submit
  @bo.tier_check_page.submit(choice: :check_tier)
  @bo.other_businesses_page.submit(choice: :no)
  @bo.construction_waste_page.submit(choice: :yes)
  @bo.carrier_type_page.submit
  @bo.renewal_information_page.submit
  @bo.registration_number_page.submit
  @bo.company_name_page.submit
  @journey_app.address_lookup_page.submit_valid_address
  people = @bo.main_people_page.main_people
  @bo.main_people_page.add_main_person(person: people[0])
  @bo.main_people_page.add_main_person(person: people[1])
  @bo.main_people_page.submit_main_person(person: people[2])
  @bo.declare_convictions_page.submit(choice: :yes)
  people = @bo.conviction_details_page.main_people
  @bo.conviction_details_page.submit(person: people[0])
  @bo.contact_name_page.submit
  @bo.contact_telephone_number_page.submit
  @bo.contact_email_page.submit(
    email: "bo-user@example.com",
    confirm_email: "bo-user@example.com"
  )
  @journey_app.address_lookup_page.submit_valid_address
  @bo.check_your_answers_page.submit
  @bo.declaration_page.submit
  @bo.registration_cards_page.submit
  @bo.payment_summary_page.submit(choice: :bank_transfer_payment)
  @bo.bank_transfer_page.submit
  @bo.renewals_dashboard_page.govuk_banner.home_page.click
end

When(/^I approve the conviction check$/) do
  @bo.renewals_dashboard_page.govuk_banner.conviction_checks.click
  visit((Quke::Quke.config.custom["urls"]["back_office_renewals"]) + "/bo/transient-registrations/#{@reg}/convictions")

  @bo.convictions_page.approve.click
  @bo.approve_convictions_page.submit(approval_reason: "ok")
end
