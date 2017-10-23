When(/^I complete my application of my public body as an upper tier waste carrier$/) do
   @app.business_type_page.submit(org_type: "publicBody")
  @app.other_businesses_question_page.submit(choice: :yes)
  @app.service_provided_question_page.submit(choice: :not_main_service)
  @app.construction_waste_question_page.submit(choice: :yes)
  @app.registration_type_page.submit(choice: :carrier_broker_dealer)
  @app.business_details_page.submit(
    company_name: "UT Public Body",
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @email = @app.generate_email
  @app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Debuilder",
    phone_number: "012345678",
    email: @email
  )
  @app.postal_address_page.submit

  people = @app.key_people_page.key_people
  @app.key_people_page.submit_key_person(person: people[0])

  @app.relevant_convictions_page.submit(choice: :no)
  @app.declaration_page.submit
  @app.sign_up_page.submit(
    registration_password: "Secret123",
    confirm_password: "Secret123",
    confirm_email: @email
  )
end