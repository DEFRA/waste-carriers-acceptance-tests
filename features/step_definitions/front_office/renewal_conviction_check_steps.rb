When(/^I complete my limited company renewal steps declaring a conviction$/) do
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
  submit_convictions("convictions")
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

When(/^I complete my limited company renewal steps not declaring a conviction$/) do
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
  people = @journey.company_people_page.dodgy_people
  @journey.company_people_page.add_main_person(person: people[0])
  @journey.company_people_page.add_main_person(person: people[1])
  @journey.company_people_page.submit_main_person(person: people[2])
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

When(/^I complete my limited company renewal steps not declaring a company conviction$/) do
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
