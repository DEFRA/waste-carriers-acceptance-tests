Given(/^I have signed into the renewals service as an agency user$/) do
  @back_renewals_app = BackOfficeRenewalsApp.new
  @journey_app = JourneyApp.new
  @back_renewals_app.sign_in_page.load
  @back_renewals_app.sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency_user"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Given(/^I have signed into the renewals service as an agency user with refunds$/) do
  @back_renewals_app = BackOfficeRenewalsApp.new
  @journey_app = JourneyApp.new
  @back_renewals_app.sign_in_page.load
  @back_renewals_app.sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency_user_with_payment_refund"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Given(/^I choose to renew "([^"]*)"$/) do |reg|
  @registration_number = reg
  @back_renewals_app.registrations_page.search(search_input: @registration_number)
  @expiry_date = @back_renewals_app.registrations_page.search_results[0].expiry_date.text
  # Turns the text expiry date into a date
  @expiry_date_year_first = Date.parse(@expiry_date)
  @back_renewals_app.registrations_page.search_results[0].renew.click
end
# rubocop:disable Metrics/LineLength
When(/^I renew the local authority registration$/) do
  @back_renewals_app.ad_privacy_policy_page.submit
  expect(@back_renewals_app.renewal_start_page.heading).to have_text("You are about to renew")
  @back_renewals_app.renewal_start_page.submit
  @back_renewals_app.location_page.submit(choice: :england_new)
  @back_renewals_app.confirm_business_type_page.submit
  @back_renewals_app.tier_check_page.submit(choice: :skip_check)
  @back_renewals_app.carrier_type_page.submit
  @back_renewals_app.renewal_information_page.submit
  @back_renewals_app.company_name_page.submit
  @back_renewals_app.post_code_page.submit(postcode: "BS1 5AH")
  @back_renewals_app.business_address_page.submit(result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH")
  people = @back_renewals_app.main_people_page.main_people
  @back_renewals_app.main_people_page.add_main_person(person: people[0])
  @back_renewals_app.main_people_page.submit_main_person(person: people[1])
  @back_renewals_app.declare_convictions_page.submit(choice: :no)
  @back_renewals_app.contact_name_page.submit
  @back_renewals_app.contact_telephone_number_page.submit
  @back_renewals_app.contact_email_page.submit(
    email: "bo-user@example.com",
    confirm_email: "bo-user@example.com"
  )
  @back_renewals_app.contact_postcode_page.submit(postcode: "BS1 5AH")
  @back_renewals_app.contact_address_page.submit(result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH")
  @back_renewals_app.check_your_answers_page.submit
  @back_renewals_app.declaration_page.submit
  @back_renewals_app.registration_cards_page.submit
  @back_renewals_app.payment_summary_page.submit(choice: :card_payment)

  submit_valid_card_payment

end

When(/^I renew the limited company registration$/) do
  @back_renewals_app.ad_privacy_policy_page.submit
  @back_renewals_app.renewal_start_page.submit
  @back_renewals_app.location_page.submit(choice: :england_new)
  @back_renewals_app.confirm_business_type_page.submit
  @back_renewals_app.tier_check_page.submit(choice: :check_tier)
  @back_renewals_app.other_businesses_page.submit(choice: :no)
  @back_renewals_app.construction_waste_page.submit(choice: :yes)
  @back_renewals_app.carrier_type_page.submit
  @back_renewals_app.renewal_information_page.submit
  @back_renewals_app.registration_number_page.submit
  @back_renewals_app.company_name_page.submit
  @back_renewals_app.post_code_page.submit(postcode: "BS1 5AH")
  @back_renewals_app.business_address_page.manual_address_submit
  @back_renewals_app.manual_address_page.submit(
    house_number: "1",
    address_line_one: "Test lane",
    address_line_two: "Testville",
    city: "Teston"
  )
  people = @back_renewals_app.main_people_page.main_people
  @back_renewals_app.main_people_page.add_main_person(person: people[0])
  @back_renewals_app.main_people_page.add_main_person(person: people[1])
  @back_renewals_app.main_people_page.submit_main_person(person: people[2])
  @back_renewals_app.declare_convictions_page.submit(choice: :no)
  @back_renewals_app.contact_name_page.submit
  @back_renewals_app.contact_telephone_number_page.submit
  @back_renewals_app.contact_email_page.submit(
    email: "bo-user@example.com",
    confirm_email: "bo-user@example.com"
  )
  @back_renewals_app.contact_postcode_page.submit(postcode: "BS1 9XX")
  @back_renewals_app.contact_postcode_page.manual_address.click
  @back_renewals_app.contact_manual_address_page.submit(
    house_number: "1",
    address_line_one: "Test lane",
    address_line_two: "Testville",
    city: "Teston"
  )
  @back_renewals_app.check_your_answers_page.submit
  @back_renewals_app.declaration_page.submit
  @back_renewals_app.registration_cards_page.submit
  @back_renewals_app.payment_summary_page.submit(choice: :card_payment)

  submit_valid_card_payment

end

Given(/^"([^"]*)" has been partially renewed by the account holder$/) do |reg|
  # save registration number for checks later on
  @registration_number = reg
  @back_renewals_app = RenewalsApp.new
  @journey_app = JourneyApp.new
  @back_renewals_app.start_page.load
  @back_renewals_app.start_page.submit(renewal: true)
  @back_renewals_app.existing_registration_page.submit(reg_no: @registration_number)
  @back_renewals_app.waste_carrier_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["waste_carrier"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  @back_renewals_app.renewal_start_page.submit
  @back_renewals_app.location_page.submit(choice: :england_new)

  Capybara.reset_session!
end

When(/^I complete the renewal "([^"]*)" for the account holder$/) do |reg|
  @back_renewals_app.renewals_dashboard_page.submit(search_term: reg)
  @back_renewals_app.renewals_dashboard_page.results[0].actions.click
  find_link("Resume application").click
  @back_renewals_app.confirm_business_type_page.submit
  @back_renewals_app.tier_check_page.submit(choice: :skip_check)
  @back_renewals_app.carrier_type_page.submit
  @back_renewals_app.renewal_information_page.submit
  @back_renewals_app.company_name_page.submit
  @back_renewals_app.post_code_page.submit(postcode: "BS1 5AH")
  @back_renewals_app.business_address_page.submit(result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH")
  people = @back_renewals_app.main_people_page.main_people
  @back_renewals_app.main_people_page.add_main_person(person: people[0])
  @back_renewals_app.main_people_page.submit_main_person(person: people[1])
  @back_renewals_app.declare_convictions_page.submit(choice: :no)
  @back_renewals_app.contact_name_page.submit
  @back_renewals_app.contact_telephone_number_page.submit
  @back_renewals_app.contact_email_page.submit
  @back_renewals_app.contact_postcode_page.submit(postcode: "BS1 5AH")
  @back_renewals_app.contact_address_page.submit(result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH")
  @back_renewals_app.check_your_answers_page.submit
  @back_renewals_app.declaration_page.submit
  @back_renewals_app.registration_cards_page.submit
  @back_renewals_app.payment_summary_page.submit(choice: :card_payment)

  submit_valid_card_payment

end

Then(/^the registration will have been renewed$/) do
  expect(@back_renewals_app.finish_assisted_page).to have_text(@registration_number)
  expect(@back_renewals_app.finish_assisted_page).to have_text("Renewal complete")
end
When(/^I have my public body upper tier renewal completed for me$/) do
  @back_app.agency_sign_in_page.load
  @back_app.registrations_page.search(search_input: @registration_number)
  @back_app.registrations_page.search_results[0].renew.click
  @back_app.business_type_page.submit
  @back_app.other_businesses_question_page.submit(choice: :no)
  @back_app.construction_waste_question_page.submit(choice: :yes)
  @back_app.registration_type_page.submit(choice: :carrier_broker_dealer)
  @back_app.renewal_information_page.submit
  @back_app.post_code_page.submit(postcode: "BS1 5AH")
  @back_app.business_address_page.submit(
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  people = @back_app.key_people_page.key_people

  @back_app.key_people_page.submit_key_person(person: people[0])
  @back_app.relevant_convictions_page.submit(choice: :no)
  @back_app.correspondence_contact_name_page.submit
  @back_app.correspondence_contact_telephone_page.submit
  @back_app.correspondence_contact_email_page.submit
  @back_app.contact_address_page.submit
  @back_app.check_details_page.submit_button.click
end

Given(/^an Environment Agency user has signed in to complete a renewal$/) do
  @back_renewals_app = BackOfficeApp.new
  @journey_app = JourneyApp.new
  @back_renewals_app.agency_sign_in_page.load
  @back_renewals_app.agency_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency_user"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Given(/^an Agency super user has signed in to the admin area$/) do
  @back_renewals_app = BackOfficeApp.new
  @journey_app = JourneyApp.new
  @back_renewals_app.admin_sign_in_page.load
  @back_renewals_app.admin_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency_super"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Given(/^has created an agency user for "([^"]*)"$/) do |user|
  @back_renewals_app.agency_users_page.add_user.click
  @back_renewals_app.agency_users_page.submit(
    email: user,
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  @user = user
  expect(@back_renewals_app.agency_users_page).to have_text("Agency user was successfully created.")
  @back_renewals_app.agency_users_page.sign_out.click
end

When(/^an Agency super user has signed into the back office$/) do
  @back_renewals_app.sign_in_page.load
  @back_renewals_app.sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency_super"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

When(/^migrates the backend users to the back office$/) do
  @back_renewals_app.renewals_dashboard_page.govuk_banner.manage_users.click
  expect(@back_renewals_app.users_page).to_not have_text(@user)
  @back_renewals_app.users_page.migrate_users.click
  @back_renewals_app.migrate_page.migrate_users.click
  expect(@back_renewals_app.migrate_page).to have_text(@user)
end

Then(/^the user has been added to the back office$/) do
  expect(@back_renewals_app.migrate_page).to have_text(@user)
end

When(/^I search for "([^"]*)" pending payment$/) do |reg|
  @back_renewals_app.renewals_dashboard_page.govuk_banner.home_page.click
  @back_renewals_app.renewals_dashboard_page.submit(search_term: reg.to_sym)
  # saves registration for later use
  @reg = reg
end

When(/^I mark the renewal payment as received$/) do
  @back_renewals_app.renewals_dashboard_page.results[0].actions.click
  @back_renewals_app.transient_registrations_page.process_payment.click
  @back_renewals_app.renewal_payments_page.submit(choice: :cash)
  @back_renewals_app.cash_payment_page.submit(
    amount: "105",
    day: "01",
    month: "01",
    year: "1980",
    reference: "0101010",
    comment: "cash money"
  )
end

Then(/^the registration will have a "([^"]*)" status$/) do |status|
  @back_renewals_app.renewals_dashboard_page.govuk_banner.home_page.click
  @back_renewals_app.renewals_dashboard_page.submit(search_term: @reg)
  expect(@back_renewals_app.renewals_dashboard_page.results_table).to have_text(status)
end

Then(/^the expiry date should be three years from the previous expiry date$/) do
  # Adds three years to expiry date and then checks expiry date reported in registration details
  @expected_expiry_date = @expiry_date_year_first.next_year(3)
  visit(Quke::Quke.config.custom["urls"]["back_office"])
  @back_renewals_app.registrations_page.search(search_input: @registration_number)
  actual_expiry_date = Date.parse(@back_renewals_app.registrations_page.search_results[0].expiry_date.text)
  expect(@expected_expiry_date).to eq(actual_expiry_date)
end

Given(/^I renew the limited company registration declaring a conviction and paying by bank transfer$/) do
  @back_renewals_app.ad_privacy_policy_page.submit
  @back_renewals_app.renewal_start_page.submit
  @back_renewals_app.location_page.submit(choice: :england_new)
  @back_renewals_app.confirm_business_type_page.submit
  @back_renewals_app.tier_check_page.submit(choice: :check_tier)
  @back_renewals_app.other_businesses_page.submit(choice: :no)
  @back_renewals_app.construction_waste_page.submit(choice: :yes)
  @back_renewals_app.carrier_type_page.submit
  @back_renewals_app.renewal_information_page.submit
  @back_renewals_app.registration_number_page.submit
  @back_renewals_app.company_name_page.submit
  @back_renewals_app.post_code_page.submit(postcode: "BS1 5AH")
  @back_renewals_app.business_address_page.submit(
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  people = @back_renewals_app.main_people_page.main_people
  @back_renewals_app.main_people_page.add_main_person(person: people[0])
  @back_renewals_app.main_people_page.add_main_person(person: people[1])
  @back_renewals_app.main_people_page.submit_main_person(person: people[2])
  @back_renewals_app.declare_convictions_page.submit(choice: :yes)
  people = @back_renewals_app.conviction_details_page.main_people
  @back_renewals_app.conviction_details_page.submit(person: people[0])
  @back_renewals_app.contact_name_page.submit
  @back_renewals_app.contact_telephone_number_page.submit
  @back_renewals_app.contact_email_page.submit(
    email: "bo-user@example.com",
    confirm_email: "bo-user@example.com"
  )
  @back_renewals_app.contact_postcode_page.submit(postcode: "BS1 5AH")
  @back_renewals_app.contact_address_page.submit(result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH")
  @back_renewals_app.check_your_answers_page.submit
  @back_renewals_app.declaration_page.submit
  @back_renewals_app.registration_cards_page.submit
  @back_renewals_app.payment_summary_page.submit(choice: :bank_transfer_payment)
  @back_renewals_app.bank_transfer_page.submit
  @back_renewals_app.renewals_dashboard_page.govuk_banner.home_page.click
end

When(/^I approve the conviction check$/) do
  @back_renewals_app.renewals_dashboard_page.govuk_banner.conviction_checks.click
  visit((Quke::Quke.config.custom["urls"]["back_office_renewals"]) + "/bo/transient-registrations/#{@reg}/convictions")

  @back_renewals_app.convictions_page.approve.click
  @back_renewals_app.approve_convictions_page.submit(approval_reason: "ok")
end
# rubocop:enable Metrics/LineLength
