When(/^I complete my limited company renewal without changing any information paying by credit card$/) do
  @front_app.renewal_start_page.submit
  @front_app.business_type_page.submit
  @front_app.other_businesses_question_page.submit(choice: :no)
  @front_app.construction_waste_question_page.submit(choice: :yes)
  @front_app.registration_type_page.submit
  @front_app.renewal_information_page.submit
  @front_app.limited_company_number_page.submit(companies_house_number: @companies_house_number)
  @front_app.company_name_page.submit
  @front_app.post_code_page.submit(postcode: "BS1 5AH")
  @front_app.business_address_page.submit(
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  people = @front_app.key_people_page.key_people

  @front_app.key_people_page.add_key_person(person: people[0])
  @front_app.key_people_page.add_key_person(person: people[1])
  @front_app.key_people_page.submit_key_person(person: people[2])
  @front_app.relevant_convictions_page.submit(choice: :no)
  @front_app.correspondence_contact_name_page.submit
  @front_app.correspondence_contact_telephone_page.submit
  @front_app.correspondence_contact_email_page.submit
  @front_app.contact_address_page.submit
  @front_app.check_details_page.submit_button.click
  @front_app.order_page.submit(
    copy_card_number: "1",
    choice: :card_payment
  )

  submit_valid_card_payment

end

When(/^I complete my limited company registration without changing any information paying by bank transfer$/) do
  @front_app.renewal_start_page.submit
  @front_app.business_type_page.submit
  @front_app.other_businesses_question_page.submit(choice: :no)
  @front_app.construction_waste_question_page.submit(choice: :yes)
  @front_app.registration_type_page.submit
  @front_app.renewal_information_page.submit
  @front_app.limited_company_number_page.submit(companies_house_number: @companies_house_number)
  @front_app.company_name_page.submit
  @front_app.post_code_page.submit(postcode: "BS1 5AH")
  @front_app.business_address_page.submit(
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  people = @front_app.key_people_page.key_people

  @front_app.key_people_page.add_key_person(person: people[0])
  @front_app.key_people_page.add_key_person(person: people[1])
  @front_app.key_people_page.submit_key_person(person: people[2])
  @front_app.relevant_convictions_page.submit(choice: :no)
  @front_app.correspondence_contact_name_page.submit
  @front_app.correspondence_contact_telephone_page.submit
  @front_app.correspondence_contact_email_page.submit
  @front_app.contact_address_page.submit
  @front_app.check_details_page.submit_button.click
  @front_app.order_page.submit(
    copy_card_number: "1",
    choice: :bank_transfer
  )
  @front_app.offline_payment_page.submit
end
