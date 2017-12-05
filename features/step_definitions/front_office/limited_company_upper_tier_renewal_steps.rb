When(/^I complete my limited company renewal without changing any information paying by credit card$/) do
  @front_app.renewal_start_page.submit
  @front_app.business_type_page.submit
  @front_app.other_businesses_question_page.submit(choice: :no)
  @front_app.construction_waste_question_page.submit(choice: :yes)
  @front_app.registration_type_page.submit
  @front_app.renewal_information_page.submit
  @front_app.limited_company_number_page.submit(companies_house_number: @companies_house_number)
  @front_app.company_name_page.submit
  @front_app.post_code_page.submit(postcode: "S60 1BY")
  @front_app.business_address_page.submit(
    result: "ENVIRONMENT AGENCY, BOW BRIDGE CLOSE, ROTHERHAM, S60 1BY"
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
  @front_app.declaration_page.submit_button.click
  @front_app.order_page.submit(
    copy_card_number: "1",
    choice: :card_payment
  )
  @front_app.worldpay_card_choice_page.maestro.click

  # finds today's date and adds another year to expiry date
  time = Time.new

  @year = time.year + 1

  @front_app.worldpay_card_details_page.submit(
    card_number: "6759649826438453",
    security_code: "555",
    cardholder_name: "3d.authorised",
    expiry_month: "12",
    expiry_year: @year
  )
  @front_app.worldpay_card_details_page.submit_button.click
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
  @front_app.post_code_page.submit(postcode: "S60 1BY")
  @front_app.business_address_page.submit(
    result: "ENVIRONMENT AGENCY, BOW BRIDGE CLOSE, ROTHERHAM, S60 1BY"
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
  @front_app.declaration_page.submit_button.click
  @front_app.order_page.submit(
    copy_card_number: "1",
    choice: :bank_transfer
  )
  @front_app.offline_payment_page.submit
end
