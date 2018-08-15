Given(/^I have signed into the renewals service$/) do
  @back_renewals_app = BackOfficeRenewalsApp.new
  @back_renewals_app.admin_sign_in_page.load
  @back_renewals_app.admin_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["back_office_renewals_user"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Given(/^I choose to renew "([^"]*)"$/) do |reg|
  renewal_url = Quke::Quke.config.custom["urls"]["back_office_renewals"] + "/bo/renew/#{reg}"

  visit(renewal_url)
  # save registration number for checks later on
  @registration_number = reg
end
# rubocop:disable Metrics/LineLength
When(/^I renew the local authority registration$/) do
  @back_renewals_app.renewal_start_page.submit
  @back_renewals_app.location_page.submit(location: "England")
  @back_renewals_app.confirm_business_type_page.submit(answer: "Local authority or public body")
  @back_renewals_app.tier_check_page.submit(answer: "I know I need an upper tier registration (continue)")
  @back_renewals_app.carrier_type_page.submit
  @back_renewals_app.renewal_information_page.submit
  @back_renewals_app.company_name_page.submit
  @back_renewals_app.post_code_page.submit(postcode: "BS1 5AH")
  @back_renewals_app.business_address_page.submit(result: "NATURAL ENGLAND, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH")
  people = @back_renewals_app.main_people_page.main_people
  @back_renewals_app.main_people_page.add_main_person(person: people[0])
  @back_renewals_app.main_people_page.submit_main_person(person: people[1])
  @back_renewals_app.declare_convictions_page.submit(answer: "No")
  @back_renewals_app.contact_name_page.submit
  @back_renewals_app.contact_telephone_number_page.submit
  @back_renewals_app.contact_email_page.submit(
    email: "bo-user@example.com",
    confirm_email: "bo-user@example.com"
  )
  @back_renewals_app.contact_postcode_page.submit(postcode: "BS1 5AH")
  @back_renewals_app.contact_address_page.submit(result: "NATURAL ENGLAND, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH")
  @back_renewals_app.check_your_answers_page.submit
  @back_renewals_app.declaration_page.submit(declaration: "I understand and agree with the declaration above")
  @back_renewals_app.registration_cards_page.submit
  @back_renewals_app.payment_summary_page.submit(answer: "Pay by credit card or debit card")
  @back_renewals_app.worldpay_card_choice_page.submit
  # finds today's date and adds another year to expiry date
  # rubocop:enable Metrics/LineLength
  time = Time.new

  @year = time.year + 1
  @back_renewals_app.worldpay_card_details_page.wait_for_heading
  @back_renewals_app.worldpay_card_details_page.submit(
    card_number: "6759649826438453",
    security_code: "555",
    cardholder_name: "3d.authorised",
    expiry_month: "12",
    expiry_year: @year
  )
  @back_renewals_app.worldpay_secure_page.submit
end

When(/^I renew the limited company registration$/) do
  @back_renewals_app.renewal_start_page.submit
  @back_renewals_app.location_page.submit(location: "England")
  @back_renewals_app.confirm_business_type_page.submit
  @back_renewals_app.tier_check_page.submit(answer: "I want to check my tier is correct before renewing")
  @back_renewals_app.other_businesses_page.submit(answer: "No")
  @back_renewals_app.construction_waste_page.submit(answer: "Yes")
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
  @back_renewals_app.declare_convictions_page.submit(answer: "No")
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
  @back_renewals_app.declaration_page.submit(declaration: "I understand and agree with the declaration above")
  @back_renewals_app.registration_cards_page.submit
  @back_renewals_app.payment_summary_page.submit(answer: "Pay by credit card or debit card")
  @back_renewals_app.worldpay_card_choice_page.submit
  # finds today's date and adds another year to expiry date
  time = Time.new

  @year = time.year + 1
  @back_renewals_app.worldpay_card_details_page.wait_for_heading
  @back_renewals_app.worldpay_card_details_page.submit(
    card_number: "6759649826438453",
    security_code: "555",
    cardholder_name: "3d.authorised",
    expiry_month: "12",
    expiry_year: @year
  )
  @back_renewals_app.worldpay_secure_page.submit
end
