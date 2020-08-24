When(/^I complete my application of my partnership as a upper tier waste carrier$/) do
  @old.old_business_type_page.submit(org_type: "partnership")
  @old.other_businesses_question_page.submit(choice: :yes)
  @old.service_provided_question_page.submit(choice: :main_service)
  @old.only_deal_with_question_page.submit(choice: :not_farm_waste)
  @old.registration_type_page.submit(choice: :broker_dealer)
  @old.business_details_page.submit(
    company_name: "Upper Tier Partnership",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @email_address = generate_email
  @old.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "0117 4960000",
    email: @email_address
  )
  @old.postal_address_page.submit

  people = @old.key_people_page.key_people

  @old.key_people_page.add_key_person(person: people[0])
  @old.key_people_page.add_key_person(person: people[1])
  @old.key_people_page.submit_key_person(person: people[2])
  @old.relevant_convictions_page.submit(choice: :no)
  @old.check_details_page.submit
  @old.sign_up_page.submit(
    registration_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_email: @email_address
  )
end

When(/^I complete my application of my public body as an upper tier waste carrier$/) do
  @old.old_business_type_page.submit(org_type: "publicBody")
  @old.other_businesses_question_page.submit(choice: :yes)
  @old.service_provided_question_page.submit(choice: :not_main_service)
  @old.construction_waste_question_page.submit(choice: :yes)
  @old.registration_type_page.submit(choice: :carrier_broker_dealer)
  @old.business_details_page.submit(
    company_name: "UT Public Body",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )

  @email_address = generate_email
  @old.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Debuilder",
    phone_number: "0117 4960000",
    email: @email_address
  )
  @old.postal_address_page.submit

  people = @old.key_people_page.key_people
  @old.key_people_page.submit_key_person(person: people[0])

  @old.relevant_convictions_page.submit(choice: :no)
  @old.check_details_page.submit
  @old.sign_up_page.submit(
    registration_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_email: @email_address
  )
end

When(/^I complete my application of my sole trader business as a upper tier waste carrier$/) do
  @old.old_business_type_page.submit(org_type: "soleTrader")
  @old.other_businesses_question_page.submit(choice: :yes)
  @old.service_provided_question_page.submit(choice: :not_main_service)
  @old.construction_waste_question_page.submit(choice: :yes)
  @old.registration_type_page.submit(choice: :carrier_dealer)
  @old.business_details_page.submit(
    company_name: "UT Sole Trader",
    postcode: "BS1 5AH",
    result: "HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  )
  @email_address = generate_email
  @old.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Debuilder",
    phone_number: "0117 4960000",
    email: @email_address
  )
  @old.postal_address_page.submit

  people = @old.key_people_page.key_people
  @old.key_people_page.submit_key_person(person: people[0])

  @old.relevant_convictions_page.submit(choice: :no)
  @old.check_details_page.submit
  @old.sign_up_page.submit(
    registration_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_password: ENV["WCRS_DEFAULT_PASSWORD"],
    confirm_email: @email_address
  )
end
