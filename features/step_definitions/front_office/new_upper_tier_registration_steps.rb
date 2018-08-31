When(/^I complete my aplication of my partnership as a upper tier waste carrier$/) do
  @front_app.business_type_page.submit(org_type: "partnership")
  @front_app.other_businesses_question_page.submit(choice: :yes)
  @front_app.service_provided_question_page.submit(choice: :main_service)
  @front_app.only_deal_with_question_page.submit(choice: :not_farm_waste)
  @front_app.registration_type_page.submit(choice: :broker_dealer)
  @front_app.business_details_page.submit(
    company_name: "Upper Tier Partnership",
    postcode: "BS1 5AH",
    result: "NATURAL ENGLAND, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @email_address = @front_app.generate_email
  @front_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "012345678",
    email: @email_address
  )
  @front_app.postal_address_page.submit

  people = @front_app.key_people_page.key_people

  @front_app.key_people_page.add_key_person(person: people[0])
  @front_app.key_people_page.add_key_person(person: people[1])
  @front_app.key_people_page.submit_key_person(person: people[2])
  @front_app.relevant_convictions_page.submit(choice: :no)
  @front_app.check_details_page.submit
  @front_app.sign_up_page.submit(
    registration_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_email: @email_address
  )
end

When(/^I complete my application of my public body as an upper tier waste carrier$/) do
  @front_app.business_type_page.submit(org_type: "publicBody")
  @front_app.other_businesses_question_page.submit(choice: :yes)
  @front_app.service_provided_question_page.submit(choice: :not_main_service)
  @front_app.construction_waste_question_page.submit(choice: :yes)
  @front_app.registration_type_page.submit(choice: :carrier_broker_dealer)
  @front_app.business_details_page.submit(
    company_name: "UT Public Body",
    postcode: "BS1 5AH",
    result: "NATURAL ENGLAND, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @email_address = @front_app.generate_email
  @front_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Debuilder",
    phone_number: "012345678",
    email: @email_address
  )
  @front_app.postal_address_page.submit

  people = @front_app.key_people_page.key_people
  @front_app.key_people_page.submit_key_person(person: people[0])

  @front_app.relevant_convictions_page.submit(choice: :no)
  @front_app.check_details_page.submit
  @front_app.sign_up_page.submit(
    registration_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_email: @email_address
  )
end

When(/^I complete my application of my sole trader business as a upper tier waste carrier$/) do
  @front_app.business_type_page.submit(org_type: "soleTrader")
  @front_app.other_businesses_question_page.submit(choice: :yes)
  @front_app.service_provided_question_page.submit(choice: :not_main_service)
  @front_app.construction_waste_question_page.submit(choice: :yes)
  @front_app.registration_type_page.submit(choice: :carrier_dealer)
  @front_app.business_details_page.submit(
    company_name: "UT Sole Trader",
    postcode: "BS1 5AH",
    result: "NATURAL ENGLAND, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @email_address = @front_app.generate_email
  @front_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Debuilder",
    phone_number: "012345678",
    email: @email_address
  )
  @front_app.postal_address_page.submit

  people = @front_app.key_people_page.key_people
  @front_app.key_people_page.submit_key_person(person: people[0])

  @front_app.relevant_convictions_page.submit(choice: :no)
  @front_app.check_details_page.submit
  @front_app.sign_up_page.submit(
    registration_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_email: @email_address
  )
end
