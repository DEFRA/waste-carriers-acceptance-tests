When(/^I complete my limited company renewal steps declaring a conviction$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.location_page.submit(location: "England")
  @renewals_app.confirm_business_type_page.submit
  @renewals_app.tier_check_page.submit(answer: "I want to check my tier is correct before renewing")
  @renewals_app.other_businesses_page.submit(answer: "No")
  @renewals_app.construction_waste_page.submit(answer: "Yes")
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
  @renewals_app.declare_convictions_page.submit(answer: "Yes")
  people = @renewals_app.conviction_details_page.main_people
  @renewals_app.conviction_details_page.submit(person: people[0])
  @renewals_app.contact_name_page.submit
  @renewals_app.contact_telephone_number_page.submit
  @renewals_app.contact_email_page.submit(
    email: "test@example.com",
    confirm_email: "test@example.com"
  )
  @renewals_app.contact_postcode_page.submit(postcode: "BS1 5AH")
  @renewals_app.contact_address_page.submit(result: "NATURAL ENGLAND, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH")
  @renewals_app.check_your_answers_page.submit
  @renewals_app.declaration_page.submit(declaration: "I understand and agree with the declaration above")
  @renewals_app.registration_cards_page.submit
  @renewals_app.payment_summary_page.submit(answer: "Pay by credit card or debit card")
  @renewals_app.worldpay_card_details_page.submit_button_renew
  @renewals_app.worldpay_card_details_page.submit_button.click
end
