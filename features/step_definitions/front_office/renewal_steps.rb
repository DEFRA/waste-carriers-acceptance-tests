Given(/^I renew my registration using my previous registration number "([^"]*)"$/) do |reg|
  @renewals_app = RenewalsApp.new
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
  @renewals_app.renewal_start_page.wait_for_heading
  expect(@renewals_app.renewal_start_page).to have_text(@registration_number)
  expect(@renewals_app.renewal_start_page.current_url).to include "/renew/CBDU"
end

When(/^I choose to renew my registration from my registrations list$/) do
  @renewals_app.waste_carrier_registrations_page.wait_for_sign_out
  @renewals_app.waste_carrier_registrations_page.registrations[0].renew_registration.click
end

Given(/^I choose to renew my registration$/) do
  Capybara.reset_session!
  @renewals_app = RenewalsApp.new
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
  @renewals_app.renewal_start_page.submit
  @renewals_app.location_page.submit(choice: :england)
  @renewals_app.confirm_business_type_page.submit(org_type: "soleTrader")
end

Then(/^I'm informed I'll need to apply for a new registration$/) do
  expect(@renewals_app.type_change_page).to have_text("You cannot renew")
end

Then(/^I will have renewed my registration$/) do
  expect(@renewals_app.confirmation_page).to have_text("Renewal complete")
end

Then(/^I will be informed my renewal is received$/) do
  expect(@renewals_app.renewal_received_page).to have_text("Renewal received")
  expect(@renewals_app.renewal_received_page).to have_text(@registration_number)
end

When(/^I change my carrier broker dealer type to "([^"]*)"$/) do |registration_type|
  @renewals_app.renewal_start_page.submit
  @renewals_app.location_page.submit(choice: :england)
  @renewals_app.confirm_business_type_page.submit
  @renewals_app.tier_check_page.submit(choice: :check_tier)
  @renewals_app.other_businesses_page.submit(choice: :yes)
  @renewals_app.service_provided_page.submit(choice: :not_main_service)
  @renewals_app.construction_waste_page.submit(choice: :yes)
  @renewals_app.carrier_type_page.submit(choice: registration_type.to_sym)
end

When(/^I answer questions indicating I should be a lower tier waste carrier$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.location_page.submit(choice: :england)
  @renewals_app.confirm_business_type_page.submit
  @renewals_app.tier_check_page.submit(choice: :check_tier)
  @renewals_app.other_businesses_page.submit(choice: :yes)
  @renewals_app.service_provided_page.submit(choice: :main_service)
  @renewals_app.waste_types_page.submit(choice: :yes_only)
end

Given(/^I have signed in to renew my registration as "([^"]*)"$/) do |username|
  @renewals_app = RenewalsApp.new
  @renewals_app.waste_carrier_sign_in_page.submit(
    email: username,
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  @email_address = username
end

Given(/^I have signed in to view my registrations as "([^"]*)"$/) do |username|
  @front_app = FrontOfficeApp.new
  @front_app.waste_carrier_sign_in_page.load
  @front_app.waste_carrier_sign_in_page.submit(
    email: username,
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Given(/^I choose registration "([^"]*)" for renewal$/) do |reg_no|
  @renewals_app = RenewalsApp.new
  @registration_number = reg_no

  @renewals_app.waste_carrier_registrations_page.renew(reg: reg_no)

end

When(/^I complete my limited company renewal steps$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.location_page.submit(choice: :england)
  @renewals_app.confirm_business_type_page.submit
  @renewals_app.tier_check_page.submit(choice: :check_tier)
  @renewals_app.other_businesses_page.submit(choice: :no)
  @renewals_app.construction_waste_page.submit(choice: :yes)
  @renewals_app.carrier_type_page.submit
  @renewals_app.renewal_information_page.submit
  @renewals_app.registration_number_page.submit
  @renewals_app.company_name_page.submit
  @renewals_app.post_code_page.submit(postcode: "BS1 5AH")
  @renewals_app.business_address_page.manual_address_submit
  @renewals_app.manual_address_page.submit(
    house_number: "1",
    address_line_one: "Test lane",
    address_line_two: "Testville",
    city: "Teston"
  )
  people = @renewals_app.main_people_page.main_people
  @renewals_app.main_people_page.add_main_person(person: people[0])
  @renewals_app.main_people_page.add_main_person(person: people[1])
  @renewals_app.main_people_page.submit_main_person(person: people[2])
  @renewals_app.declare_convictions_page.submit(choice: :no)
  @renewals_app.contact_name_page.submit
  @renewals_app.contact_telephone_number_page.submit
  @renewals_app.contact_email_page.submit
  @renewals_app.contact_postcode_page.submit(postcode: "BS1 9XX")
  @renewals_app.contact_postcode_page.manual_address.click
  @renewals_app.contact_manual_address_page.submit(
    house_number: "1",
    address_line_one: "Test lane",
    address_line_two: "Testville",
    city: "Teston"
  )
  @renewals_app.check_your_answers_page.submit
  @renewals_app.declaration_page.submit
  @renewals_app.registration_cards_page.submit
  @renewals_app.payment_summary_page.submit(choice: :card_payment)
  @renewals_app.worldpay_card_choice_page.submit
  # finds today's date and adds another year to expiry date
  time = Time.new

  @year = time.year + 1

  @renewals_app.worldpay_card_details_page.submit(
    card_number: "6759649826438453",
    security_code: "555",
    cardholder_name: "3d.authorised",
    expiry_month: "12",
    expiry_year: @year
  )
  @renewals_app.worldpay_secure_page.submit
end

Given(/^I change the business type to "([^"]*)"$/) do |org_type|
  @renewals_app.renewal_start_page.submit
  @renewals_app.location_page.submit(choice: :england)
  @renewals_app.confirm_business_type_page.submit(org_type: org_type)
end

Given(/^I change my place of business location to "([^"]*)"$/) do |location|
  @renewals_app.renewal_start_page.submit
  @renewals_app.location_page.submit(choice: location.to_sym)
end

Then(/^I will be able to continue my renewal$/) do
  @renewals_app.tier_check_page.wait_for_check_tier
  expect(@renewals_app.tier_check_page.current_url).to include "/tier-check"
  Capybara.reset_session!
end

When(/^I complete my sole trader renewal steps$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.location_page.submit(choice: :england)
  @renewals_app.confirm_business_type_page.submit
  @renewals_app.tier_check_page.submit(choice: :check_tier)
  @renewals_app.other_businesses_page.submit(choice: :yes)
  @renewals_app.service_provided_page.submit(choice: :not_main_service)
  @renewals_app.construction_waste_page.submit(choice: :yes)
  @renewals_app.carrier_type_page.submit
  @renewals_app.renewal_information_page.submit
  @renewals_app.company_name_page.submit
  @renewals_app.post_code_page.submit(postcode: "BS1 5AH")
  @renewals_app.business_address_page.submit(result: "NATURAL ENGLAND, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH")
  people = @renewals_app.main_people_page.main_people
  @renewals_app.main_people_page.submit_main_person(person: people[0])
  @renewals_app.declare_convictions_page.submit(choice: :no)
  @renewals_app.contact_name_page.submit
  @renewals_app.contact_telephone_number_page.submit
  @renewals_app.contact_email_page.submit(
    email: "test@example.com",
    confirm_email: "test@example.com"
  )
  @renewals_app.contact_postcode_page.submit(postcode: "BS1 5AH")
  @renewals_app.contact_address_page.submit(result: "NATURAL ENGLAND, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH")
  @renewals_app.check_your_answers_page.submit
  @renewals_app.declaration_page.submit
  @renewals_app.registration_cards_page.submit
  @renewals_app.payment_summary_page.submit(choice: :card_payment)
  @renewals_app.worldpay_card_choice_page.submit
  # finds today's date and adds another year to expiry date
  time = Time.new

  @year = time.year + 1

  @renewals_app.worldpay_card_details_page.submit(
    card_number: "6759649826438453",
    security_code: "555",
    cardholder_name: "3d.authorised",
    expiry_month: "12",
    expiry_year: @year
  )
  @renewals_app.worldpay_secure_page.submit
end

When(/^I complete my local authority renewal steps$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.location_page.submit(choice: :england)
  @renewals_app.confirm_business_type_page.submit
  @renewals_app.tier_check_page.submit(choice: :skip_check)
  @renewals_app.carrier_type_page.submit
  @renewals_app.renewal_information_page.submit
  @renewals_app.company_name_page.submit
  @renewals_app.post_code_page.submit(postcode: "BS1 5AH")
  @renewals_app.business_address_page.submit(result: "NATURAL ENGLAND, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH")
  people = @renewals_app.main_people_page.main_people
  @renewals_app.main_people_page.add_main_person(person: people[0])
  @renewals_app.main_people_page.submit_main_person(person: people[1])
  @renewals_app.declare_convictions_page.submit(choice: :no)
  @renewals_app.contact_name_page.submit
  @renewals_app.contact_telephone_number_page.submit
  @renewals_app.contact_email_page.submit
  @renewals_app.contact_postcode_page.submit(postcode: "BS1 5AH")
  @renewals_app.contact_address_page.submit(result: "NATURAL ENGLAND, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH")
  @renewals_app.check_your_answers_page.submit
  @renewals_app.declaration_page.submit
  @renewals_app.registration_cards_page.submit
  @renewals_app.payment_summary_page.submit(choice: :card_payment)
  @renewals_app.worldpay_card_choice_page.submit
  # finds today's date and adds another year to expiry date
  time = Time.new

  @year = time.year + 1

  @renewals_app.worldpay_card_details_page.submit(
    card_number: "6759649826438453",
    security_code: "555",
    cardholder_name: "3d.authorised",
    expiry_month: "12",
    expiry_year: @year
  )
  @renewals_app.worldpay_secure_page.submit
end

When(/^I complete my limited liability partnership renewal steps$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.location_page.submit(choice: :england)
  @renewals_app.confirm_business_type_page.submit
  @renewals_app.tier_check_page.submit(choice: :check_tier)
  @renewals_app.other_businesses_page.submit(choice: :yes)
  @renewals_app.service_provided_page.submit(choice: :not_main_service)
  @renewals_app.construction_waste_page.submit(choice: :yes)
  @renewals_app.carrier_type_page.submit
  @renewals_app.renewal_information_page.submit
  @renewals_app.registration_number_page.submit
  @renewals_app.company_name_page.submit
  @renewals_app.post_code_page.submit(postcode: "BS1 5AH")
  @renewals_app.business_address_page.manual_address_submit
  @renewals_app.manual_address_page.submit(
    house_number: "1",
    address_line_one: "Test lane",
    address_line_two: "Testville",
    city: "Teston"
  )
  people = @renewals_app.main_people_page.main_people
  @renewals_app.main_people_page.add_main_person(person: people[0])
  @renewals_app.main_people_page.add_main_person(person: people[1])
  @renewals_app.main_people_page.submit_main_person(person: people[2])
  @renewals_app.declare_convictions_page.submit(choice: :no)
  @renewals_app.contact_name_page.submit
  @renewals_app.contact_telephone_number_page.submit
  @renewals_app.contact_email_page.submit
  @renewals_app.contact_postcode_page.submit(postcode: "BS1 5AH")
  @renewals_app.contact_address_page.submit(result: "NATURAL ENGLAND, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH")
  @renewals_app.check_your_answers_page.submit
  @renewals_app.declaration_page.submit
  @renewals_app.registration_cards_page.submit
  @renewals_app.payment_summary_page.submit(choice: :card_payment)
  @renewals_app.worldpay_card_choice_page.submit
  # finds today's date and adds another year to expiry date
  time = Time.new

  @year = time.year + 1
  @renewals_app.worldpay_card_details_page.submit(
    card_number: "6759649826438453",
    security_code: "555",
    cardholder_name: "3d.authorised",
    expiry_month: "12",
    expiry_year: @year
  )
  @renewals_app.worldpay_secure_page.submit
end

When(/^I complete my limited liability partnership renewal steps choosing to pay by bank transfer$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.location_page.submit(choice: :england)
  @renewals_app.confirm_business_type_page.submit
  @renewals_app.tier_check_page.submit(choice: :check_tier)
  @renewals_app.other_businesses_page.submit(choice: :yes)
  @renewals_app.service_provided_page.submit(choice: :not_main_service)
  @renewals_app.construction_waste_page.submit(choice: :yes)
  @renewals_app.carrier_type_page.submit
  @renewals_app.renewal_information_page.submit
  @renewals_app.registration_number_page.submit
  @renewals_app.company_name_page.submit
  @renewals_app.post_code_page.submit(postcode: "BS1 5AH")
  @renewals_app.business_address_page.manual_address_submit
  @renewals_app.manual_address_page.submit(
    house_number: "1",
    address_line_one: "Test lane",
    address_line_two: "Testville",
    city: "Teston"
  )
  people = @renewals_app.main_people_page.main_people
  @renewals_app.main_people_page.add_main_person(person: people[0])
  @renewals_app.main_people_page.add_main_person(person: people[1])
  @renewals_app.main_people_page.submit_main_person(person: people[2])
  @renewals_app.declare_convictions_page.submit(choice: :no)
  @renewals_app.contact_name_page.submit
  @renewals_app.contact_telephone_number_page.submit
  @renewals_app.contact_email_page.submit
  @renewals_app.contact_postcode_page.submit(postcode: "BS1 5AH")
  @renewals_app.contact_address_page.submit(result: "NATURAL ENGLAND, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH")
  @renewals_app.check_your_answers_page.submit
  @renewals_app.declaration_page.submit
  @renewals_app.registration_cards_page.submit
  @renewals_app.payment_summary_page.submit(choice: :bank_transfer_payment)
  @renewals_app.bank_transfer_page.submit
end

When(/^I complete my partnership renewal steps$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.location_page.submit(choice: :england)
  @renewals_app.confirm_business_type_page.submit
  @renewals_app.tier_check_page.submit(choice: :check_tier)
  @renewals_app.other_businesses_page.submit(choice: :yes)
  @renewals_app.service_provided_page.submit(choice: :main_service)
  @renewals_app.waste_types_page.submit(choice: :not_only)
  @renewals_app.carrier_type_page.submit
  @renewals_app.renewal_information_page.submit
  @renewals_app.company_name_page.submit
  @renewals_app.post_code_page.submit(postcode: "BS1 5AH")
  @renewals_app.business_address_page.submit(result: "NATURAL ENGLAND, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH")
  people = @renewals_app.main_people_page.main_people
  @renewals_app.main_people_page.add_main_person(person: people[0])
  @renewals_app.main_people_page.add_main_person(person: people[1])
  @renewals_app.main_people_page.add_main_person(person: people[2])
  @renewals_app.main_people_page.add_main_person(person: people[3])
  @renewals_app.main_people_page.add_main_person(person: people[4])
  @renewals_app.main_people_page.submit_main_person(person: people[5])
  @renewals_app.declare_convictions_page.submit(choice: :no)

  @renewals_app.contact_name_page.submit
  @renewals_app.contact_telephone_number_page.submit
  @renewals_app.contact_email_page.submit
  @renewals_app.contact_postcode_page.submit(postcode: "BS1 5AH")
  @renewals_app.contact_address_page.submit(result: "NATURAL ENGLAND, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH")
  @renewals_app.check_your_answers_page.submit
  @renewals_app.declaration_page.submit
  @renewals_app.registration_cards_page.submit
  @renewals_app.payment_summary_page.submit(choice: :card_payment)
  @renewals_app.worldpay_card_choice_page.submit
  # finds today's date and adds another year to expiry date
  time = Time.new

  @year = time.year + 1

  @renewals_app.worldpay_card_details_page.submit(
    card_number: "6759649826438453",
    security_code: "555",
    cardholder_name: "3d.authorised",
    expiry_month: "12",
    expiry_year: @year
  )
  @renewals_app.worldpay_secure_page.submit
end

When(/^I add two partners to my renewal$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.location_page.submit(choice: :england)
  @renewals_app.confirm_business_type_page.submit
  @renewals_app.tier_check_page.submit(choice: :check_tier)
  @renewals_app.other_businesses_page.submit(choice: :yes)
  @renewals_app.service_provided_page.submit(choice: :main_service)
  @renewals_app.waste_types_page.submit(choice: :not_only)
  @renewals_app.carrier_type_page.submit
  @renewals_app.renewal_information_page.submit
  @renewals_app.company_name_page.submit
  @renewals_app.post_code_page.submit(postcode: "BS1 5AH")
  @renewals_app.business_address_page.submit(result: "NATURAL ENGLAND, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH")
  people = @renewals_app.main_people_page.main_people
  @renewals_app.main_people_page.add_main_person(person: people[0])
  @renewals_app.main_people_page.add_main_person(person: people[1])
end

When(/^remove one partner and attempt to continue with my renewal$/) do
  @renewals_app.main_people_page.remove_person[0].click
  @renewals_app.main_people_page.submit_button.click
end

When(/^I complete my overseas company renewal steps$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.location_page.submit(choice: :overseas)
  @renewals_app.tier_check_page.submit(choice: :check_tier)
  @renewals_app.other_businesses_page.submit(choice: :no)
  @renewals_app.construction_waste_page.submit(choice: :yes)
  @renewals_app.carrier_type_page.submit
  @renewals_app.renewal_information_page.submit
  @renewals_app.company_name_page.submit
  @renewals_app.manual_address_page.submit(
    house_number: "1",
    address_line_one: "Test lane",
    address_line_two: "Testville",
    city: "Teston",
    country: "Testopia"
  )
  people = @renewals_app.main_people_page.main_people
  @renewals_app.main_people_page.submit_main_person(person: people[0])
  @renewals_app.declare_convictions_page.submit(choice: :no)
  @renewals_app.registration_cards_page.submit
  @renewals_app.contact_name_page.submit
  @renewals_app.contact_telephone_number_page.submit
  @renewals_app.contact_email_page.submit
  @renewals_app.contact_manual_address_page.submit(
    house_number: "1",
    address_line_one: "Test lane",
    address_line_two: "Testville",
    city: "Teston",
    country: "Slovakia"
  )
  @renewals_app.check_your_answers_page.submit
  @renewals_app.declaration_page.submit
  @renewals_app.registration_cards_page.submit
  @renewals_app.payment_summary_page.submit(choice: :card_payment)
  @renewals_app.worldpay_card_choice_page.submit
  # finds today's date and adds another year to expiry date
  time = Time.new

  @year = time.year + 1

  @renewals_app.worldpay_card_details_page.submit(
    card_number: "6759649826438453",
    security_code: "555",
    cardholder_name: "3d.authorised",
    expiry_month: "12",
    expiry_year: @year,
    postcode: "90210"
  )
  @renewals_app.worldpay_secure_page.submit
end

When(/^I confirm my business type$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.location_page.submit(choice: :england)
  @renewals_app.confirm_business_type_page.submit
end

Then(/^I will be notified "([^"]*)"$/) do |message|
  expect(@renewals_app.waste_carrier_sign_in_page).to have_text(message)
  Capybara.reset_session!
end

Then(/^I will be asked to add another partner$/) do
  expect(@renewals_app.main_people_page).to have_text("You must add the details of at least 2 people")
  Capybara.reset_session!
end

Then(/^I will be notified my renewal is complete$/) do
  @renewals_app.renewal_complete_page.wait_for_heading
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
  @renewals_app.renewal_start_page.submit
  @renewals_app.location_page.submit(choice: :england)
  @renewals_app.confirm_business_type_page.submit
  @renewals_app.tier_check_page.submit(choice: :check_tier)
  @renewals_app.other_businesses_page.submit(choice: :yes)
  @renewals_app.service_provided_page.submit(choice: :not_main_service)
  @renewals_app.construction_waste_page.submit(choice: :yes)
  @renewals_app.carrier_type_page.submit
  @renewals_app.renewal_information_page.submit
  @renewals_app.registration_number_page.submit(companies_house_number: number.to_sym)
end

Then(/^I will be notified my renewal is pending checks$/) do
  @renewals_app.renewal_complete_page.wait_for_heading
  expect(@renewals_app.renewal_received_page.heading.text).to eq("Application received")
  expect(@renewals_app.renewal_received_page).to have_text(@registration_number)
  Capybara.reset_session!
end

Then(/^I will be notified my renewal is pending payment$/) do
  @renewals_app.renewal_complete_page.wait_for_heading
  expect(@renewals_app.renewal_received_page.heading.text).to eq("Application received")
  expect(@renewals_app.renewal_received_page).to have_text("pay the renewal charge")
  expect(@renewals_app.renewal_received_page).to have_text(@registration_number)
  Capybara.reset_session!
end

When(/^I try to renew anyway by guessing the renewal url for "([^"]*)"$/) do |reg_no|
  @renewals_app = RenewalsApp.new
  renewal_url = Quke::Quke.config.custom["urls"]["front_office_renewals"] + "/fo/renew/#{reg_no}"

  visit(renewal_url)
end

When(/^view my registration on the dashboard$/) do
  @renewals_app.renewal_complete_page.finished.click
end

Then(/^I will see my registration has been renewed$/) do
  expect(@renewals_app.waste_carrier_registrations_page.registration_info[0].status.text).to have_text("ACTIVE")

  registration = @renewals_app.waste_carrier_registrations_page.registration(@registration_number)
  expect(registration[:controls].renew_registration).not_to have_text("Renew")
end

Then(/^I will be prompted to sign in to complete the renewal$/) do
  @renewals_app.waste_carriers_renewals_sign_in_page.wait_for_email_address
  expect(@renewals_app.waste_carriers_renewals_sign_in_page.current_url).to include "/users/sign_in"
end
