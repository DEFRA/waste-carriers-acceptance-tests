Given(/^I have signed into the renewals service as an agency user$/) do
  @back_renewals_app = BackOfficeRenewalsApp.new
  @back_renewals_app.admin_sign_in_page.load
  @back_renewals_app.admin_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency_user"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Given(/^I have signed into the renewals service as an agency user with refunds$/) do
  @back_renewals_app = BackOfficeRenewalsApp.new
  @back_renewals_app.admin_sign_in_page.load
  @back_renewals_app.admin_sign_in_page.submit(
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
  @back_renewals_app.renewal_start_page.submit
  @back_renewals_app.location_page.submit(choice: :england)
  @back_renewals_app.confirm_business_type_page.submit
  @back_renewals_app.tier_check_page.submit(choice: :skip_check)
  @back_renewals_app.carrier_type_page.submit
  @back_renewals_app.renewal_information_page.submit
  @back_renewals_app.company_name_page.submit
  @back_renewals_app.post_code_page.submit(postcode: "BS1 5AH")
  @back_renewals_app.business_address_page.submit(result: "NATURAL ENGLAND, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH")
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
  @back_renewals_app.contact_address_page.submit(result: "NATURAL ENGLAND, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH")
  @back_renewals_app.check_your_answers_page.submit
  @back_renewals_app.declaration_page.submit
  @back_renewals_app.registration_cards_page.submit
  @back_renewals_app.payment_summary_page.submit(choice: :card_payment)
  @back_renewals_app.worldpay_card_choice_page.submit
  # finds today's date and adds another year to expiry date

  time = Time.new

  @year = time.year + 1

  @back_renewals_app.worldpay_card_details_page.submit(
    card_number: "6759649826438453",
    security_code: "555",
    cardholder_name: "3d.authorised",
    expiry_month: "12",
    expiry_year: @year
  )
end

When(/^I renew the limited company registration$/) do
  @back_renewals_app.renewal_start_page.submit
  @back_renewals_app.location_page.submit(choice: :england)
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
  @back_renewals_app.worldpay_card_choice_page.submit
  # finds today's date and adds another year to expiry date
  time = Time.new

  @year = time.year + 1

  @back_renewals_app.worldpay_card_details_page.submit(
    card_number: "6759649826438453",
    security_code: "555",
    cardholder_name: "3d.authorised",
    expiry_month: "12",
    expiry_year: @year
  )
end

Given(/^"([^"]*)" has been partially renewed by the account holder$/) do |reg|
  # save registration number for checks later on
  @registration_number = reg
  @back_renewals_app = RenewalsApp.new
  @back_renewals_app.start_page.load
  @back_renewals_app.start_page.submit(renewal: true)
  @back_renewals_app.existing_registration_page.submit(reg_no: @registration_number)
  @back_renewals_app.waste_carrier_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["waste_carrier"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  @back_renewals_app.renewal_start_page.submit
  @back_renewals_app.location_page.submit(choice: :england)

  visit("/fo/users/sign_out")
end

When(/^I complete the renewal "([^"]*)" for the account holder$/) do |reg|
  @back_renewals_app.renewals_dashboard_page.submit(
    search_term: reg,
    choice: :in_progress
  )
  @back_renewals_app.renewals_dashboard_page.results[0].actions.click
  @back_renewals_app.transient_registrations_page.continue_as_assisted_digital.click
  @back_renewals_app.confirm_business_type_page.submit
  @back_renewals_app.tier_check_page.submit(choice: :skip_check)
  @back_renewals_app.carrier_type_page.submit
  @back_renewals_app.renewal_information_page.submit
  @back_renewals_app.company_name_page.submit
  @back_renewals_app.post_code_page.submit(postcode: "BS1 5AH")
  @back_renewals_app.business_address_page.submit(result: "NATURAL ENGLAND, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH")
  people = @back_renewals_app.main_people_page.main_people
  @back_renewals_app.main_people_page.add_main_person(person: people[0])
  @back_renewals_app.main_people_page.submit_main_person(person: people[1])
  @back_renewals_app.declare_convictions_page.submit(choice: :no)
  @back_renewals_app.contact_name_page.submit
  @back_renewals_app.contact_telephone_number_page.submit
  @back_renewals_app.contact_email_page.submit
  @back_renewals_app.contact_postcode_page.submit(postcode: "BS1 5AH")
  @back_renewals_app.contact_address_page.submit(result: "NATURAL ENGLAND, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH")
  @back_renewals_app.check_your_answers_page.submit
  @back_renewals_app.declaration_page.submit
  @back_renewals_app.registration_cards_page.submit
  @back_renewals_app.payment_summary_page.submit(choice: :card_payment)
  @back_renewals_app.worldpay_card_choice_page.submit
  # finds today's date and adds another year to expiry date

  time = Time.new

  @year = time.year + 1

  @back_renewals_app.worldpay_card_details_page.submit(
    card_number: "6759649826438453",
    security_code: "555",
    cardholder_name: "3d.authorised",
    expiry_month: "12",
    expiry_year: @year
  )
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
    result: "NATURAL ENGLAND, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
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
  @back_renewals_app.agency_sign_in_page.load
  @back_renewals_app.agency_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency_user"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

When(/^I search for "([^"]*)" pending payment$/) do |reg|
  @back_renewals_app.renewals_dashboard_page.back_office_link.click
  @back_renewals_app.renewals_dashboard_page.submit(
    search_term: reg.to_sym,
    choice: :pending_payment
  )
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
  @back_renewals_app.renewals_dashboard_page.back_office_link.click
  @back_renewals_app.renewals_dashboard_page.submit(
    search_term: @reg,
    choice: :pending_conviction
  )
  expect(@back_renewals_app.renewals_dashboard_page.results[0].status).to have_text(status)
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
  @back_renewals_app.renewal_start_page.submit
  @back_renewals_app.location_page.submit(choice: :england)
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
    result: "NATURAL ENGLAND, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
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
  @back_renewals_app.contact_address_page.submit(result: "NATURAL ENGLAND, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH")
  @back_renewals_app.check_your_answers_page.submit
  @back_renewals_app.declaration_page.submit
  @back_renewals_app.registration_cards_page.submit
  @back_renewals_app.payment_summary_page.submit(choice: :bank_transfer_payment)
  @back_renewals_app.bank_transfer_page.submit
  @back_renewals_app.renewals_dashboard_page.back_office_link.click
end

When(/^I approve the conviction check$/) do
  @back_renewals_app.renewals_dashboard_page.back_office_link.click
  @back_renewals_app.renewals_dashboard_page.submit(
    search_term: @reg,
    choice: :conviction_check
  )
  @back_renewals_app.renewals_dashboard_page.results[0].actions.click
  @back_renewals_app.transient_registrations_page.check_convictions.click
  @back_renewals_app.convictions_page.approve.click
  @back_renewals_app.approve_convictions_page.submit(approval_reason: "ok")
end
# rubocop:enable Metrics/LineLength
