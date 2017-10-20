When(/^I complete my aplication of my partnership as a upper tier waste carrier$/) do
  @app.business_type_page.submit(org_type: "partnership")
  @app.other_businesses_question_page.submit(choice: :yes)
  @app.service_provided_question_page.submit(choice: :main_service)
  @app.only_deal_with_question_page.submit(choice: :not_farm_waste)
  @app.registration_type_page.submit(choice: :broker_dealer)
  @app.business_details_page.submit(
    company_name: "UT Partnership",
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @email = @app.generate_email
  @app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "012345678",
    email: @email
  )
  @app.postal_address_page.submit

  people = @app.key_people_page.key_people

  @app.key_people_page.add_key_person(person: people[0])
  @app.key_people_page.add_key_person(person: people[1])
  @app.key_people_page.submit_key_person(person: people[2])

  @app.relevant_convictions_page.submit(choice: :no)
  @app.declaration_page.submit
  @app.sign_up_page.submit(
    registration_password: "Secret123",
    confirm_password: "Secret123",
    confirm_email: @email
  )
end
