When(/^I complete my limited company renewal steps declaring a conviction$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.location_page.submit(choice: :england_new)
  @renewals_app.confirm_business_type_page.submit
  @renewals_app.tier_check_page.submit(choice: :check_tier)
  @renewals_app.other_businesses_page.submit(choice: :no)
  @renewals_app.construction_waste_page.submit(choice: :yes)
  @renewals_app.carrier_type_page.submit
  @renewals_app.renewal_information_page.submit
  @renewals_app.registration_number_page.submit
  @renewals_app.company_name_page.submit
  @journey_app.address_lookup_page.choose_manual_address
  @journey_app.address_manual_page.submit(
    house_number: "1",
    address_line_one: "Test lane",
    address_line_two: "Testville",
    city: "Teston"
  )
  people = @renewals_app.main_people_page.main_people
  @renewals_app.main_people_page.add_main_person(person: people[0])
  @renewals_app.main_people_page.add_main_person(person: people[1])
  @renewals_app.main_people_page.submit_main_person(person: people[2])
  @renewals_app.declare_convictions_page.submit(choice: :yes)
  people = @renewals_app.conviction_details_page.main_people
  @renewals_app.conviction_details_page.submit(person: people[0])
  @renewals_app.contact_name_page.submit
  @renewals_app.contact_telephone_number_page.submit
  @renewals_app.contact_email_page.submit(
    email: "test@example.com",
    confirm_email: "test@example.com"
  )
  @journey_app.address_lookup_page.submit_valid_address
  @renewals_app.check_your_answers_page.submit
  @renewals_app.declaration_page.submit
  @renewals_app.registration_cards_page.submit
  @renewals_app.payment_summary_page.submit(choice: :card_payment)

  submit_valid_card_payment

end

When(/^I complete my limited company renewal steps not declaring a conviction$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.location_page.submit(choice: :england_new)
  @renewals_app.confirm_business_type_page.submit
  @renewals_app.tier_check_page.submit(choice: :check_tier)
  @renewals_app.other_businesses_page.submit(choice: :no)
  @renewals_app.construction_waste_page.submit(choice: :yes)
  @renewals_app.carrier_type_page.submit
  @renewals_app.renewal_information_page.submit
  @renewals_app.registration_number_page.submit
  @renewals_app.company_name_page.submit
  @journey_app.address_lookup_page.choose_manual_address
  @journey_app.address_manual_page.submit(
    house_number: "1",
    address_line_one: "Test lane",
    address_line_two: "Testville",
    city: "Teston"
  )
  people = @renewals_app.main_people_page.dodgy_people
  @renewals_app.main_people_page.add_main_person(person: people[0])
  @renewals_app.main_people_page.add_main_person(person: people[1])
  @renewals_app.main_people_page.submit_main_person(person: people[2])
  @renewals_app.declare_convictions_page.submit(choice: :no)
  @renewals_app.contact_name_page.submit
  @renewals_app.contact_telephone_number_page.submit
  @renewals_app.contact_email_page.submit(
    email: "test@example.com",
    confirm_email: "test@example.com"
  )
  @journey_app.address_lookup_page.submit_valid_address
  @renewals_app.check_your_answers_page.submit
  @renewals_app.declaration_page.submit
  @renewals_app.registration_cards_page.submit
  @renewals_app.payment_summary_page.submit(choice: :card_payment)

  submit_valid_card_payment

end

When(/^I complete my limited company renewal steps not declaring a company conviction$/) do
  @renewals_app.renewal_start_page.submit
  @renewals_app.location_page.submit(choice: :england_new)
  @renewals_app.confirm_business_type_page.submit
  @renewals_app.tier_check_page.submit(choice: :check_tier)
  @renewals_app.other_businesses_page.submit(choice: :no)
  @renewals_app.construction_waste_page.submit(choice: :yes)
  @renewals_app.carrier_type_page.submit
  @renewals_app.renewal_information_page.submit
  @renewals_app.registration_number_page.submit
  @renewals_app.company_name_page.submit
  @journey_app.address_lookup_page.choose_manual_address
  @journey_app.address_manual_page.submit(
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
  @renewals_app.contact_email_page.submit(
    email: "test@example.com",
    confirm_email: "test@example.com"
  )
  @journey_app.address_lookup_page.submit_valid_address
  @renewals_app.check_your_answers_page.submit
  @renewals_app.declaration_page.submit
  @renewals_app.registration_cards_page.submit
  @renewals_app.payment_summary_page.submit(choice: :card_payment)
  submit_valid_card_payment
end
