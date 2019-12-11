Given(/^I renew my registration using my previous registration number "([^"]*)"$/) do |reg|
  @renewals_app = RenewalsApp.new
  @journey = JourneyApp.new
  @renewals_app.start_page.load
  @renewals_app.start_page.submit(renewal: true)
  @renewals_app.existing_registration_page.submit(reg_no: reg)
  # save registration number for checks later on
  @registration_number = reg
end

Then(/^I will be shown the renewal information page$/) do
  expect(@renewals_app.renewal_start_page).to have_text(@registration_number)
  expect(@renewals_app.renewal_start_page.current_url).to include "/renewal-information"
end

Then(/^I will be shown the renewal start page$/) do
  @renewals_app.renewal_start_page.wait_until_heading_visible
  expect(@renewals_app.renewal_start_page).to have_text(@registration_number)
  expect(@renewals_app.renewal_start_page.current_url).to include "/renew/CBDU"
end

When(/^I choose to renew my registration from my registrations list$/) do
  @renewals_app.waste_carrier_registrations_page.wait_until_sign_out_visible
  @renewals_app.waste_carrier_registrations_page.registrations[0].renew_registration.click
end

Given(/^I choose to renew my registration$/) do
  Capybara.reset_session!
  @renewals_app = RenewalsApp.new
  @journey = JourneyApp.new
  @renewals_app.start_page.load
  @renewals_app.start_page.submit(renewal: true)
  @renewals_app.existing_registration_page.submit(reg_no: @registration_number)
end

When(/^I enter my lower tier registration number "([^"]*)"$/) do |reg_no|
  @renewals_app.existing_registration_page.submit(reg_no: reg_no)
end

Then(/^I'm informed "([^"]*)"$/) do |error_message|
  expect(@renewals_app.existing_registration_page.error_message.text).to eq(error_message)
end

When(/^the organisation type is changed to sole trader$/) do
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit(org_type: "soleTrader")
end

Then(/^I'm informed I'll need to apply for a new registration$/) do
  expect(@renewals_app.type_change_page).to have_text("You cannot renew")
end

Then(/^I will be informed my renewal is received$/) do
  expect(@renewals_app.renewal_received_page).to have_text("Renewal received")
  expect(@renewals_app.renewal_received_page).to have_text(@registration_number)
end

When(/^I change my carrier broker dealer type to "([^"]*)"$/) do |registration_type|
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :check_tier)
  @renewals_app.other_businesses_page.submit(choice: :yes)
  @renewals_app.service_provided_page.submit(choice: :not_main_service)
  @renewals_app.construction_waste_page.submit(choice: :yes)
  @journey.carrier_type_page.submit(choice: registration_type.to_sym)
end

When(/^I answer questions indicating I should be a lower tier waste carrier$/) do
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :check_tier)
  @renewals_app.other_businesses_page.submit(choice: :yes)
  @renewals_app.service_provided_page.submit(choice: :main_service)
  @renewals_app.waste_types_page.submit(choice: :yes_only)
end

Given(/^I have signed in to renew my registration as "([^"]*)"$/) do |username|
  @renewals_app = RenewalsApp.new
  @journey = JourneyApp.new
  @renewals_app.waste_carrier_sign_in_page.submit(
    email: username,
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  @email_address = username
end

Given(/^I have signed in to view my registrations as "([^"]*)"$/) do |username|
  @front_app = FrontOfficeApp.new
  @journey = JourneyApp.new
  @front_app.waste_carrier_sign_in_page.load
  @front_app.waste_carrier_sign_in_page.submit(
    email: username,
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Given(/^I choose registration "([^"]*)" for renewal$/) do |reg_no|
  @renewals_app = RenewalsApp.new
  @journey = JourneyApp.new
  @registration_number = reg_no

  @front_app.waste_carrier_registrations_page.find_registration(@registration_number)
  @front_app.waste_carrier_registrations_page.renew(@registration_number)
end

When(/^I complete my limited company renewal steps$/) do
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :check_tier)
  @renewals_app.other_businesses_page.submit(choice: :no)
  @renewals_app.construction_waste_page.submit(choice: :yes)
  @journey.carrier_type_page.submit
  @renewals_app.renewal_information_page.submit
  @journey.company_number_page.submit
  @journey.company_name_page.submit
  @journey.address_lookup_page.choose_manual_address
  @journey.address_manual_page.submit(
    house_number: "1",
    address_line_one: "Test lane",
    address_line_two: "Testville",
    city: "Teston"
  )
  submit_company_people
  submit_convictions("no convictions")
  @journey.contact_name_page.submit
  @journey.contact_phone_page.submit
  @journey.contact_email_page.submit
  @journey.address_lookup_page.submit_invalid_address
  @journey.address_manual_page.submit(
    house_number: "1",
    address_line_one: "Test lane",
    address_line_two: "Testville",
    city: "Teston"
  )
  check_your_answers
  @renewals_app.registration_cards_page.submit
  @renewals_app.payment_summary_page.submit(choice: :card_payment)
  submit_valid_card_payment
end

Given(/^I change the business type to "([^"]*)"$/) do |org_type|
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit(org_type: org_type)
end

Given(/^I change my place of business location to "([^"]*)"$/) do |location|
  @renewals_app.renewal_start_page.submit
  @renewals_app.location_page.submit(choice: location.to_sym)
end

Then(/^I will be able to continue my renewal$/) do
  @journey.tier_check_page.wait_until_check_tier_visible
  expect(@journey.tier_check_page.current_url).to include "/tier-check"
  Capybara.reset_session!
end

When(/^I complete my sole trader renewal steps$/) do
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :check_tier)
  @renewals_app.other_businesses_page.submit(choice: :yes)
  @renewals_app.service_provided_page.submit(choice: :not_main_service)
  @renewals_app.construction_waste_page.submit(choice: :yes)
  @journey.carrier_type_page.submit
  @renewals_app.renewal_information_page.submit
  @journey.company_name_page.submit
  @journey.address_lookup_page.submit_valid_address
  people = @journey.company_people_page.main_people
  @journey.company_people_page.submit_main_person(person: people[0])
  submit_convictions("no convictions")
  @journey.contact_name_page.submit
  @journey.contact_phone_page.submit
  @journey.contact_email_page.submit(
    email: "test@example.com",
    confirm_email: "test@example.com"
  )
  @journey.address_lookup_page.submit_valid_address
  check_your_answers
  @renewals_app.registration_cards_page.submit
  @renewals_app.payment_summary_page.submit(choice: :card_payment)
  submit_valid_card_payment
end

When(/^I complete my local authority renewal steps$/) do
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :skip_check)
  @journey.carrier_type_page.submit
  @renewals_app.renewal_information_page.submit
  @journey.company_name_page.submit
  @journey.address_lookup_page.submit_valid_address
  submit_company_people
  submit_convictions("no convictions")
  @journey.contact_name_page.submit
  @journey.contact_phone_page.submit
  @journey.contact_email_page.submit
  @journey.address_lookup_page.submit_valid_address
  check_your_answers
  @renewals_app.registration_cards_page.submit
  @renewals_app.payment_summary_page.submit(choice: :card_payment)
  submit_valid_card_payment
end

When(/^I complete my limited liability partnership renewal steps$/) do
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :check_tier)
  @renewals_app.other_businesses_page.submit(choice: :yes)
  @renewals_app.service_provided_page.submit(choice: :not_main_service)
  @renewals_app.construction_waste_page.submit(choice: :yes)
  @journey.carrier_type_page.submit
  @renewals_app.renewal_information_page.submit
  @journey.company_number_page.submit
  @journey.company_name_page.submit
  @journey.address_lookup_page.choose_manual_address
  @journey.address_manual_page.submit(
    house_number: "1",
    address_line_one: "Test lane",
    address_line_two: "Testville",
    city: "Teston"
  )
  submit_company_people
  submit_convictions("no convictions")
  @journey.contact_name_page.submit
  @journey.contact_phone_page.submit
  @journey.contact_email_page.submit
  @journey.address_lookup_page.submit_valid_address
  check_your_answers
  @renewals_app.registration_cards_page.submit
  @renewals_app.payment_summary_page.submit(choice: :card_payment)
  submit_valid_card_payment
end

When(/^I complete my limited liability partnership renewal steps choosing to pay by bank transfer$/) do
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :check_tier)
  @renewals_app.other_businesses_page.submit(choice: :yes)
  @renewals_app.service_provided_page.submit(choice: :not_main_service)
  @renewals_app.construction_waste_page.submit(choice: :yes)
  @journey.carrier_type_page.submit
  @renewals_app.renewal_information_page.submit
  @journey.company_number_page.submit
  @journey.company_name_page.submit
  @journey.address_lookup_page.choose_manual_address
  @journey.address_manual_page.submit(
    house_number: "1",
    address_line_one: "Test lane",
    address_line_two: "Testville",
    city: "Teston"
  )
  submit_company_people
  submit_convictions("no convictions")
  @journey.contact_name_page.submit
  @journey.contact_phone_page.submit
  @journey.contact_email_page.submit
  @journey.address_lookup_page.submit_valid_address
  check_your_answers
  @renewals_app.registration_cards_page.submit
  @renewals_app.payment_summary_page.submit(choice: :bank_transfer_payment)
  @renewals_app.bank_transfer_page.submit
end

When(/^I complete my partnership renewal steps$/) do
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :check_tier)
  @renewals_app.other_businesses_page.submit(choice: :yes)
  @renewals_app.service_provided_page.submit(choice: :main_service)
  @renewals_app.waste_types_page.submit(choice: :not_only)
  @journey.carrier_type_page.submit
  @renewals_app.renewal_information_page.submit
  @journey.company_name_page.submit
  @journey.address_lookup_page.submit_valid_address
  submit_company_people
  submit_convictions("no convictions")
  @journey.contact_name_page.submit
  @journey.contact_phone_page.submit
  @journey.contact_email_page.submit
  @journey.address_lookup_page.submit_valid_address
  check_your_answers
  @renewals_app.registration_cards_page.submit
  @renewals_app.payment_summary_page.submit(choice: :card_payment)
  submit_valid_card_payment
end

When(/^I add two partners to my renewal$/) do
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :check_tier)
  @renewals_app.other_businesses_page.submit(choice: :yes)
  @renewals_app.service_provided_page.submit(choice: :main_service)
  @renewals_app.waste_types_page.submit(choice: :not_only)
  @journey.carrier_type_page.submit
  @renewals_app.renewal_information_page.submit
  @journey.company_name_page.submit
  @journey.address_lookup_page.submit_valid_address
  people = @journey.company_people_page.main_people
  @journey.company_people_page.add_main_person(person: people[0])
  @journey.company_people_page.add_main_person(person: people[1])
end

When(/^remove one partner and attempt to continue with my renewal$/) do
  @journey.company_people_page.remove_person[0].click
  @journey.company_people_page.submit_button.click
end

When(/^I complete my overseas company renewal steps$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.location_page.submit(choice: :overseas)
  @journey.tier_check_page.submit(choice: :check_tier)
  @renewals_app.other_businesses_page.submit(choice: :no)
  @renewals_app.construction_waste_page.submit(choice: :yes)
  @journey.carrier_type_page.submit
  @renewals_app.renewal_information_page.submit
  @journey.company_name_page.submit
  @journey.address_manual_page.submit(
    house_number: "1",
    address_line_one: "Via poerio",
    address_line_two: "Via poerio",
    postcode: "00152", # required, as tests currently fail without a postcode
    city: "Rome",
    country: "Italy"
  )
  people = @journey.company_people_page.main_people
  @journey.company_people_page.submit_main_person(person: people[0])
  submit_convictions("no convictions")
  @renewals_app.registration_cards_page.submit
  @journey.contact_name_page.submit
  @journey.contact_phone_page.submit
  @journey.contact_email_page.submit
  @journey.address_manual_page.submit(
    house_number: "1",
    address_line_one: "Via poerio",
    address_line_two: "Via Poerio",
    city: "Rome",
    postcode: "00152", # required, as tests currently fail without a postcode
    country: "Italy"
  )
  check_your_answers
  @renewals_app.registration_cards_page.submit
  @renewals_app.payment_summary_page.submit(choice: :card_payment)
  submit_valid_card_payment
end

When(/^I confirm my business type$/) do
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
end

Then(/^I will be notified "([^"]*)"$/) do |message|
  expect(@renewals_app.waste_carrier_sign_in_page).to have_text(message)
  Capybara.reset_session!
end

Then(/^I will be asked to add another partner$/) do
  expect(@journey.company_people_page).to have_text("You must add the details of at least 2 people")
  Capybara.reset_session!
end

Then(/^I will be notified my renewal is complete$/) do
  @renewals_app.renewal_complete_page.wait_until_heading_visible
  expect(@renewals_app.renewal_complete_page.heading.text).to eq("Renewal complete")
  expect(@renewals_app.renewal_complete_page).to have_text(@registration_number)
  Capybara.reset_session!
end

Then(/^I will be advised "([^"]*)"$/) do |message|
  expect(@renewals_app.renewal_information_page).to have_text(message)
  Capybara.reset_session!
end

Then(/^I will be told my registration can not be renewed$/) do
  expect(@renewals_app.unrenewable_page).to have_text("This registration cannot be renewed")
end

When(/^the renewal date is over one month before it is due to expire$/) do
  # No code to write here, step added so the test reads better
end

When(/^the registration is within the expiry grace renewal window$/) do
  # No code to write here, step added so the test reads better
end

Given(/^I change my companies house number to "([^"]*)"$/) do |number|
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :check_tier)
  @renewals_app.other_businesses_page.submit(choice: :yes)
  @renewals_app.service_provided_page.submit(choice: :not_main_service)
  @renewals_app.construction_waste_page.submit(choice: :yes)
  @journey.carrier_type_page.submit
  @renewals_app.renewal_information_page.submit
  @journey.company_number_page.submit(companies_house_number: number.to_sym)
end

Then(/^I will be notified my renewal is pending checks$/) do
  @renewals_app.renewal_received_page.wait_until_heading_visible
  expect(@renewals_app.renewal_received_page.heading.text).to eq("Application received")
  expect(@renewals_app.renewal_received_page).to have_text(@registration_number)
  Capybara.reset_session!
end

Then(/^I will be notified my renewal is pending payment$/) do
  @renewals_app.renewal_received_page.wait_until_heading_visible
  expect(@renewals_app.renewal_received_page.heading.text).to eq("Application received")
  expect(@renewals_app.renewal_received_page).to have_text("pay the renewal charge")
  expect(@renewals_app.renewal_received_page).to have_text(@registration_number)
  Capybara.reset_session!
end

When(/^I try to renew anyway by guessing the renewal url for "([^"]*)"$/) do |reg_no|
  @renewals_app = RenewalsApp.new
  @journey = JourneyApp.new
  renewal_url = Quke::Quke.config.custom["urls"]["front_office_renewals"] + "/fo/renew/#{reg_no}"

  visit(renewal_url)
end

When(/^view my registration on the dashboard$/) do
  @renewals_app.renewal_complete_page.finished.click
end

Then(/^I will see my registration "([^"]*)" has been renewed$/) do |reg|
  @registration_number = reg
  @renewals_app.waste_carrier_registrations_page.find_registration(@registration_number)

  status = @renewals_app.waste_carrier_registrations_page.check_status(@registration_number)
  expect(status).to have_text("Active")

  expect(@renewals_app.waste_carrier_registrations_page.renewable?(@registration_number)).to be false
end

Then(/^I will be prompted to sign in to complete the renewal$/) do
  @renewals_app.waste_carriers_renewals_sign_in_page.wait_until_email_address_visible
  expect(@renewals_app.waste_carriers_renewals_sign_in_page.current_url).to include "/users/sign_in"
end
